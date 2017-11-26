class User < ActiveRecord::Base

  has_many :rooms
  has_many :bookings
  has_many :reviews
	belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
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

  def self.from_omniauth(auth)
    puts "auth: #{auth.as_json}"
    puts "********************************"
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      puts "user: #{user.as_json}"
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
