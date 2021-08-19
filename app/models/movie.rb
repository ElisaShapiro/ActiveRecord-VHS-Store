class Movie < ActiveRecord::Base
    has_many :genres
    has_many :moviegenres, through: :genres
    has_many :vhs
    has_many :rentals, through: :vhs

    def self.available_now
        self.all.filter{|avail| avail.rentals.filter {|avail2| avail2.current == false}}
    end

    def number_of_rentals
        self.vhs.sum{|vhs| vhs.rentals.count}
    end

    def self.by_female_director
        self.select{|movie| movie.female_director}
    end
    
    def self.most_popular_female_director
        self.by_female_director.max_by{|movie| movie.number_of_rentals}.director
    end

    def self.newest_first
        self.all.sort_by(&:year).reverse
    end

    def self.longest
        self.all.sort_by(&:length).reverse
    end
end