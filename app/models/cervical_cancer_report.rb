class CervicalCancerReport < ApplicationRecord
  belongs_to :user
  belongs_to :algorithm, optional: true
end
