require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views
 
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  
  	it "devrait avoir le bon titre" do
      get :new
      expect(response.body).to have_title('Simple App du Tutoriel Ruby on Rails | S\'inscrire')
    end
  end
  
  describe "POST 'create'" do

	describe "échec" do

      before(:each) do
        @attr = { :nom => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "ne devrait pas créer d'utilisateur" do
        lambda do
          post :create, :user => @attr
        end.to change(User, :count)
      end

      it "devrait avoir le bon titre" do
        post :create, :user => @attr
        expect(response.body).to have_title('Simple App du Tutoriel Ruby on Rails | S\'inscrire')
      end

      it "devrait rendre la page 'new'" do
        post :create, :user => @attr
        expect(response).to render_template('new')
      end
    end
  end
end
