module Overcommit::Hook::PreCommit

  class Il8nUnused < Base

    # Overcommit expects you to override this method which will be called
    # everytime your pre_commit hook is run.
    # In this we call out to the i18n-tasks gem which should already be
    # installed to run its unused task. This checks the .yml files in
    # config/locales against references to them, and flags any where there is an
    # entry in the .yml files that is not referenced.
    def run
      command ||= ["i18n-tasks", "unused"]

      result = execute(command)

      return :pass if(result.success? && result.stdout.empty?)

      puts
      puts result.stderr.to_s
      puts result.stdout.to_s

      :fail
    end

  end
end
