require 'spec_helper'

describe Admin::PostsController do

  before(:each) do
    stub_authorize_user!
  end

  describe "admin panel" do
    it "#index" do
      get :index
      expect(assigns(:posts)).to eq Post.all
    end

    it "#new" do
      get :new
      expect(response).to render_template(:new)
    end

    context "#create" do
      it "creates a post with valid params" do
        valid_params = FactoryGirl.attributes_for(:valid_post)
        expect{post :create, post:valid_params}.to change{Post.count}.by(1)
      end
      it "doesn't create a post when params are invalid" do
        invalid_params = FactoryGirl.attributes_for(:invalid_post)
        expect{post :create, post:invalid_params}.to change{Post.count}.by(0)
      end
    end

    context "#edit" do
      it "updates a post with valid params" do
        existing_post = FactoryGirl.create(:valid_post)
        attrs = FactoryGirl.attributes_for(:valid_post)
        patch :update, {id:existing_post.id, post: attrs}
        expect(existing_post.reload.title).to eq(attrs[:title])
        expect(response).to redirect_to admin_post_path(existing_post)
      end

      it "doesn't update a post when params are invalid" do
        existing_post = FactoryGirl.create(:valid_post)
        saved_title = existing_post.title
        attrs = FactoryGirl.attributes_for(:invalid_post)
        patch :update, {id:existing_post.id, post: attrs}
        expect(existing_post.reload.title).to eq(saved_title)
        expect(response).to render_template(:edit)
      end
    end

    it "#destroy" do
      existing_post = FactoryGirl.create(:valid_post)
      id = existing_post.id
      delete :destroy, id:id
      expect(Post.find_by(id: id)).to eq(nil)
      expect(response).to redirect_to(admin_posts_path)
    end
  end
end
