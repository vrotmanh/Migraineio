class Algorithm < ApplicationRecord
  validates :code, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  belongs_to :user
  has_many :migraine_reports
  has_many :cervical_cancer_reports
end
