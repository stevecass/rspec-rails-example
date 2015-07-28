class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  before_save :set_name_from_email

  private

  def set_name_from_email
    self.name = email.sub(/@.+/, '')
  end


end
