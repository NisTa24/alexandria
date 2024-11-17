class Author < ApplicationRecord
  include PgSearch
  multisearchable against: [ :given_name, :family_name ]

  validates :given_name, presence: true
  validates :family_name, presence: true

  has_many :books
end
