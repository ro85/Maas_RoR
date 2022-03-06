class Contract < ApplicationRecord
  validates :client_name, presence: true
end
