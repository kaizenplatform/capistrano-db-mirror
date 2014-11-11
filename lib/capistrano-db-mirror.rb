module Capistrano
  module DbMirror
    VERSION = ::File.read(::File.expand_path('../../VERSION', __FILE__)).to_s.strip

    class << self
      attr_accessor :excludes, :sanitizer, :dump_dir

      def excludes
        @excludes ||= [:production]
      end

      def sanitizer
        {
          '*' => {
            email: "CONCAT('user-', id, '@sanitized-email.com')"
          }
        }
      end

      def dump_dir
        @dump_dir ||= './dump'
      end
    end
  end
end

if defined?(::Rake)
  require 'rake'
  Dir.glob(File.join(__dir__, 'capistrano', 'db-mirror', 'tasks', '**', '*.rake')) { |path| load path }
end
