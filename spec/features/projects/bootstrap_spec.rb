# frozen_string_literal: true

RSpec.describe "Creating a project" do
  context "without PSO_CANNOT_CREATE_PROJECTS set" do
    context "with an rma user" do
      it_behaves_like "bootstrap a new proposal", :rma
    end

    context "with a pso user" do
      it_behaves_like "bootstrap a new proposal", :pso
    end
  end

  context "with PSO_CANNOT_CREATE_PROJECTS set" do
    around do |example|
      with_modified_env PSO_CANNOT_CREATE_PROJECTS: "1" do
        example.run
      end
    end

    context "with an rma user" do
      it_behaves_like "bootstrap a new proposal", :rma
    end

    context "with a pso user" do
      let(:user) { create(:account_user, :pso) }

      before { login_as(user) }

      it "doesn't let me bootstrap a project" do
        expect(page).not_to have_text("Create a new proposal")
      end

      it "provides a link to create an EA-led proposal" do
        expect(page).to have_text("To create a new EA-Led proposal please go to")
      end
    end
  end
end
