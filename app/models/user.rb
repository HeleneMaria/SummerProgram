# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  remember_token  :string
#


class User < ActiveRecord::Base

  has_secure_password

  validates :username, presence:true, uniqueness:{ case_sensitive: false}
  validates :password, presence:true,length: {minimum: 6}

  before_save :create_remember_token #for the session, being able to find it on everypage once signed in

  #all methods under private are automatically hidden (no possibility to see it in the console for example)
  private
  def create_remember_token #for the sign_in to be persistent even after the browser is closed
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
