module Overcommit::Hook::PreCommit

  class Il8nMissing < Base

    # Overcommit expects you to override this method which will be called
    # everytime your pre_commit hook is run.
    # In this we call out to the i18n-tasks gem which should already be
    # installed to run its missing task. This checks the .yml files in
    # config/locales against references to them, and flags any where the
    # reference is missing
    #
    # N.B Depending on your setup Over commit / git may pick up your system Ruby before your rvm/rbenv ruby

    def run
      command ||= ["i18n-tasks", "missing"]
      #command ||= ["i18n-tasks", "config"]

      result = execute(command)

      return :pass if(result.success? && result.stdout.empty?)

      puts
      puts result.stderr.to_s
      puts result.stdout.to_s

      :fail
    end

  end
end
