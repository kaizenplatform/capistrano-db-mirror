require 'capistrano-db-mirror'
Dir.glob(File.join(__dir__, 'tasks', '**', '*.cap')) { |path| load path }
