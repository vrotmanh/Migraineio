class Algorithm < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: true

  belongs_to :user
  has_many :reports
end
