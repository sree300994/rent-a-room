class User < ActiveRecord::Base

  has_many :rooms
	belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name, :username, :email, :mobile

  before_create :save_as_guest

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def save_as_guest
    role = Role.find_by("name = ?", "guest")
    self.role_id = role.id
  end

  def role?(role)
    self.role.name.include? role
  end
end
