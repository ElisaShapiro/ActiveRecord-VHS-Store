require 'date'
class Rental < ActiveRecord::Base
    belongs_to :client
    belongs_to :vhs

    def due_date
        self.created_at + 7.days
    end

    def self.past_due_date
        Rental.all.filter do |overdue|
            overdue.due_date < DateTime.now
        end
    end
end