class Movie < ActiveRecord::Base
    has_many :genres
    has_many :moviegenres, through: :genres
    has_many :vhs
    has_many :rentals, through: :vhs
end