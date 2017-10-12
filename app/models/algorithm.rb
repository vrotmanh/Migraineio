class Algorithm < ApplicationRecord
  validates :code, presence: true

  belongs_to :user
  has_many :reports
end
