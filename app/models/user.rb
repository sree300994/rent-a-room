class User < ActiveRecord::Base

	belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name, :username, :email, :mobile, :password

  def email_required?
    false
  end

  def email_changed?
    false
  end
end
