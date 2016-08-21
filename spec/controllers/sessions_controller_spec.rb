require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "devrait réussir" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "devrait avoir le bon titre" do
      get :new
      expect(response.body).to have_title('Simple App du Tutoriel Ruby on Rails | S\'identifier')
    end
  end
end