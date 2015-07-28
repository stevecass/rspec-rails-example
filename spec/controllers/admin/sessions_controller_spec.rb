require 'spec_helper'
describe Admin::SessionsController do
  context "new" do
    it "is successful" do
      get :new
      expect(response).to be_success
    end
  end
  context "#create" do
    let(:user) { FactoryGirl.create :user }
    it "redirects to root path if correct credentials" do
      post :create, :email => user.email, :password => user.password
      expect(response).to redirect_to root_path
    end
    it "redirects to sign in path with bad email" do
      post :create, :email => "wrong@email.com", :password => user.password
      expect(response).to redirect_to new_admin_session_path
    end
    it "redirects to sign in path with bad password" do
      post :create, :email => user.email, :password => "wrong password"
      expect(response).to redirect_to new_admin_session_path
    end
  end
end
