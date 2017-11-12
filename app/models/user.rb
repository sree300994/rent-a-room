class User < ActiveRecord::Base

  has_many :rooms
  has_many :bookings
  has_many :reviews
	belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name, :username, :mobile
  validates_uniqueness_of :username, :mobile, :email

  before_create :save_as_guest

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def save_as_guest
    role = Role.find_by("name = ?", "guest") # Role.find_by(name: "guest")
    self.role_id = role.id
  end

  def role?(role)
    self.role.name.include? role
  end
end
