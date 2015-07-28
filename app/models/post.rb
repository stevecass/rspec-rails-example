class Post < ActiveRecord::Base

  def self.recent
    order("created_at DESC").limit(5)
  end

  before_save :titleize_title, :generate_slug

  validates :title, :content, :presence => true

  private

  def titleize_title
    self.title = title.titleize
  end

  def generate_slug
    self.slug = title.parameterize
  end
end
