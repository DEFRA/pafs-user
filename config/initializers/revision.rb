# frozen_string_literal: true

Rails.application.config.x.revision = if Rails.root.join("REVISION").exist?
                                        Rails.root.join("REVISION").open(&:readline)
                                      else
                                        `git rev-parse --short HEAD`
                                      end
