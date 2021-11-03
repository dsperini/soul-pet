class Pet < ApplicationRecord
  belongs_to :user
  has_many :adoptions
  validates :name, presence: true, uniqueness: true
  validates :size, inclusion: {in: ['pequeno', 'médio', 'grande']}
  validates :breed, inclusion: {in: ['cão', 'gato', 'passarinho']}

  # cloudnary set-up
  has_one_attached :photo

end
