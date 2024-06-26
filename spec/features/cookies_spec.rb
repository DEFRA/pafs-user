# frozen_string_literal: true

RSpec.describe "Cookies banner and pages" do

  let(:current_cookies) { Capybara.current_session.driver.request.cookies }

  shared_examples "links to edit cookies page" do
    it "the edit cookies link is displayed" do
      expect(page).to have_link "change your cookie settings", href: edit_cookies_path
    end
  end

  describe "cookies banner" do
    before { visit "/" }

    it "displays the cookies banner" do
      expect(page).to have_css(".govuk-cookie-banner")
    end

    context "when I click on the 'View cookies' link" do
      before { click_on "View cookies" }

      it "displays the cookies page" do
        expect(page).to have_content "Cookies on Project Application and Funding Service"
      end
    end

    context "when I click the 'Accept analytics cookies' button" do
      before { click_on "Accept analytics cookies" }

      it "sets the cookies_policy cookie to 'Accepted'" do
        expect(current_cookies["cookies_policy"]).to eq "analytics_accepted"
      end

      it "displays the Analytics cookies accepted content" do
        expect(page).to have_content "You’ve accepted analytics cookies"
      end

      it_behaves_like "links to edit cookies page"
    end

    context "when I click the 'Reject analytics' cookies button" do
      before { click_on "Reject analytics cookies" }

      it "sets the cookies_policy cookie to 'Rejected'" do
        expect(current_cookies["cookies_policy"]).to eq "analytics_rejected"
      end

      it "displays the 'Analytics cookies rejected' page" do
        expect(page).to have_content "You’ve rejected analytics cookies"
      end

      it_behaves_like "links to edit cookies page"
    end

    describe "cookies page" do
      before { visit cookies_path }

      it "displays the cookies page" do
        expect(page).to have_content "Cookies on Project Application and Funding Service"
      end

      it "describes the 'cookies_policy' cookie" do
        expect(page).to have_content "cookies_policy"
      end

      it_behaves_like "links to edit cookies page"
    end

    describe "edit cookies page" do
      before { visit edit_cookies_path }

      it "displays the analytics cookies option" do
        expect(page).to have_content "Use cookies that measure my website use"
      end
    end
  end
end
