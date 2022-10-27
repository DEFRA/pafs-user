# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Response headers" do
  describe "Cache busting" do
    it "contains the headers needed to stop the client caching responses" do
      skip "cache busting not there now we've changed the root_path this will be devise login"
      get "/"

      expect(response.headers["Cache-Control"]).to eq "no-cache, no-store, max-age=0, must-revalidate, private"
      expect(response.headers["Pragma"]).to eq "no-cache"
      expect(response.headers["Expires"]).to eq "Fri, 01 Jan 1990 00:00:00 GMT"
    end
  end

  describe "Content security policy" do
    it "contains the headers needed to ensure all content comes from the service" do
      skip "secure_headers doesn't seem to get activated when running in TEST"
      get "/"

      puts response.headers

      expect(response.headers["Content-Security-Policy"]).to eq(
        "default-src 'self'; " \
        "font-src 'self' data:; " \
        "image-src 'self' www.google-analytics.com; " \
        "object-src 'self'; " \
        "script-src 'self' 'unsafe-inline' www.googletagmanager.com www.google-analytics.com; " \
        "style-src 'self'; " \
        "report-uri https://environmentagency.report-uri.io/r/default/csp/enforce"
      )
    end
  end
end
