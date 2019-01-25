# frozen_string_literal: true
require "rails_helper"

RSpec.describe "/api/v1/projects", type: :request do
  describe "GET :slug" do
    let(:slug) { "NWC501E-000A-001A" }

    it "has stores the API version in the response header"

    context "unauthorised access" do
      it "returns a 401"
    end

    context "authorised access" do
      context "project not found" do
        it "returns a 404" do
          get "/api/v1/projects/#{slug}"

          expect(response).to have_http_status(:not_found)
        end
      end

      context "requesting an existing project" do
        let(:project) { create(:project, reference_number: reference_number) }
        let(:reference_number) { "NWC501E/000A/001A" }

        it "returns a 200" do
          get "/api/v1/projects/#{project.slug}"

          expect(response).to have_http_status(:ok)
        end

        it "returns a JSON response"
      end
    end
  end
end
