Rails.application.config.x.revision = if File.exists? Rails.root.join("REVISION")
                                        File.open(Rails.root.join("REVISION"), &:readline)
                                      else
                                        `git rev-parse --short HEAD`
                                      end
