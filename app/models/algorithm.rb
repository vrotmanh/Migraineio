class Algorithm < ApplicationRecord
  belongs_to :user
  has_many :reports
end
