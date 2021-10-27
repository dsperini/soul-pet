class Pet < ApplicationRecord
  belongs_to :user
  has_many :adoptions
  validates :name, presence: true
  validates :size, inclusion: {in: ['pequeno', 'médio', 'grande']}
end
