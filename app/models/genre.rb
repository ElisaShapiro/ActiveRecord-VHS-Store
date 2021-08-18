class Genre < ActiveRecord::Base
    has_many :moviegenres
    has_many :movies, through: :moviegenres
end