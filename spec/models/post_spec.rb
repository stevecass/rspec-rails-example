require 'spec_helper'

describe Post do
  it "title should be automatically titleized before save" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    expect {
      post.save
    }.to change { post.title }.from("New post!" ).to("New Post!")
  end

  it "post should be unpublished by default" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    post.save
    expect(post.is_published).to eq(false)
  end

  # a slug is an automaticaly generated url-friendly
  # version of the title
  it "slug should be automatically generated" do
    post = Post.new
    post.title   = "New post!"
    post.content = "A great story"
    expect {
      post.save
    }.to change { post.slug }.from(nil).to("new-post")
  end
end
