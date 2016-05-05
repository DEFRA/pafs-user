#
# Prevent accidentally commiting 'focus: true' in specs.
#
module Overcommit::Hook::PreCommit
  class RspecFocusCheck < Base
    def run
      error_lines = {}
      applicable_files.each do |file|
        File.open(file, "r").each do |line|
          error_lines[file] = line if line =~ /[,\s]+focus:/ || line =~ /[,\s]+:focus/
        end
      end

      if error_lines.any?
        puts
        error_lines.each do |k, v|
          puts
          puts "#{k} contains an rspec :focus tag"
          puts v
        end
        :fail
      else
        :pass
      end
    end
  end
end
