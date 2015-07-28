require 'spec_helper'

feature 'User browsing the website' do

  let!(:sample_post) { FactoryGirl.create(:valid_post)}

  context "on homepage" do
    it "sees a list of recent posts titles" do
      visit root_path
      expect(page).to have_content('Recent Posts:')
      expect(page).to have_content(sample_post.title)
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit root_path
      click_link sample_post.title
      expect(current_path).to eq(post_path(sample_post))
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      visit post_path(sample_post)
      expect(page).to have_content(sample_post.title)
      expect(page).to have_content(sample_post.content)
    end
  end
end
