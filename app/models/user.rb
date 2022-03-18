class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_monitoring_shifts
  has_many :monitoring_shifts

  validates :name, presence: true  

  def select_colour
    rgb_digit = (1..255).to_a   
    colour = "#{rgb_digit.sample},#{rgb_digit.sample},#{rgb_digit.sample}"
  end

end
