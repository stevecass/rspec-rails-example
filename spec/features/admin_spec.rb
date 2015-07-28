require 'spec_helper'

feature 'Admin panel' do

  let!(:sample_post) { FactoryGirl.create(:valid_post)}

  before(:each) do
    stub_authorize_user!
  end

  context "on admin homepage" do
    it "can see a list of recent posts" do
      visit admin_posts_path
      expect(page).to have_content("All posts:")
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      click_link 'Edit'
      expect(page).to have_selector('form.edit_post')
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      pre_count = Post.count
      expect(page).to have_content(sample_post.title)
      click_link 'Delete'
      expect(page).to_not have_content(sample_post.title)
      post_count = Post.count
      expect(post_count).to eq(pre_count -1)
    end

    it "can create a new post and view it" do
       visit new_admin_post_path
       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)
       expect(page).to have_content "Published: true"
       expect(page).to have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      test_post = FactoryGirl.create(:published_post)
      visit edit_admin_post_path(test_post)
      uncheck('post_is_published')
      click_button('Save')
      expect(test_post.reload.is_published).to eq(false)
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      #can't make this pass without changing views.....
      visit admin_post_path(sample_post)
      click_link("post#{sample_post.id}")
      expect(current_path).to eq(post_path(sample_post))

    end

    it "can see an edit link that takes you to the edit post path" do
      visit admin_post_path(sample_post)
      click_link('Edit post')
      expect(current_path).to eq(edit_admin_post_path(sample_post))
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      visit admin_post_path(sample_post)
      click_link('Admin welcome page')
      expect(current_path).to eq(admin_posts_path)
    end
  end
end
