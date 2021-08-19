require 'pry'

class Client < ActiveRecord::Base
    has_many :rentals
    has_many :vhs, through: :rentals

    def self.first_rental(client, vhs)
        new_client = Client.create(client)
        Rental.create(client_id: new_client.id, vhs_id: vhs.id, current: true)
    end

    def past_rentals
        self.rentals.select do |rental|
            !rental.current
        end
    end
    def self.most_active
        active_clients = self.all.sort_by do |client|
            client.past_rentals.count
        end
        active_clients.reverse[0..4]
    end

    def self.non_grata
        Rental.past_due_date.map do |overduerental|
            overduerental.client.name
        end
    end
end