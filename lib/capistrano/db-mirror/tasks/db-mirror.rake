namespace :db do
  namespace :mirror do
    def load_config
      c = YAML.load_file("#{Rails.root}/config/database.yml")[Rails.env] # c == config
      c.symbolize_keys!
    end 

    desc "Create database dump via mysqldump"
    task :dump, [:dumpfile] => :environment do |t, args|
      raise "arg :dumpfile required" if args[:dumpfile].nil?

      # execute mysqldump command using database.yml credentials
      c = load_config
      cmds = ["mysqldump", "-u #{c[:username]}", "--password='#{c[:password]}'"]
      cmds << ((c[:socket].present?)? "-S #{c[:socket]}" : "-h #{c[:host]}")
      cmds.concat [c[:database], "| gzip > #{args[:dumpfile]}"]
      p "writing #{args[:dumpfile]}..."
      `#{cmds.join " "}`
    end 

    desc "Load mysqldump file to local database"
    task :load, [:dumpfile] => :environment do |t, args|
      raise "The operation is not allowed in #{Rails.env}!!" if Capistrano::DbMirror.excludes.map(&:to_s).include?(Rails.env.to_s)
      raise "arg :dumpfile does not exist: #{args[:dumpfile]}" unless File.exists? args[:dumpfile]

      # execute mysql load command using local database.yml credentials
      # - extrace gzip file
      rawfile = args[:dumpfile].sub(/\.gz$/, "")
      p rawfile
      `gunzip -c #{args[:dumpfile]} > #{rawfile}`
      # - load dumpfile
      begin
        c = load_config
        cmds = ["mysql", "-u #{c[:username]}", "--password='#{c[:password]}'"]
        cmds << "-S #{c[:socket]}" if c[:socket].present?
        cmds << "-h #{c[:host]}"   if c[:host].present?
        cmds.concat [c[:database], %Q|-e "source #{rawfile}"|]
        p "loading #{args[:dumpfile]} into database..."
        p cmds.join " " 
        `#{cmds.join " "}`
      ensure
        `rm #{rawfile}`
      end 
    end

    desc "Rollback db"
    task rollback: [:environment] do
      files = Dir.glob(File.join(Capistrano::DbMirror.dump_dir, '**', '*.dump.gz'))
      file = files.sort.reverse.first
      Rake::Task["db:mirror:load"].invoke(file)
    end

    desc "Sanitize db"
    task sanitize: [:environment] do
      raise "The operation is not allowed in #{Rails.env}!!" if Capistrano::DbMirror.excludes.map(&:to_s).include?(Rails.env.to_s)

      ActiveRecord::Base.connection.tables.each do |table_name|
        sets = []
        wheres = []
        Capistrano::DbMirror.sanitizer.select { |target, _| target == '*' || target.to_s == table_name }.each do |_, config|
          config.each do |column, format|
            if ActiveRecord::Base.connection.columns(table_name).map(&:name).include?(column.to_s)
              sets << %|`#{column}` = #{format}|
              wheres << %|`#{column}` IS NOT NULL AND `#{column}` != ""|
            end
          end
        end
        if sets.present? && wheres.present?
          sql = %|UPDATE `#{table_name}` SET #{sets.join(', ')} WHERE #{wheres.join(' AND ')}|
          puts "Execute: #{sql}"
          ActiveRecord::Base.connection.execute sql 
        end
      end
    end
  end 
end
