class Fish < ApplicationRecord
    has_many :items

    validates :name, presence: true, length: { minimum: 1, maximum: 20 }
    validates :age, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
