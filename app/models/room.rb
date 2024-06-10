class Room < ApplicationRecord
    has_many :entries, dependent: :destroy
    has_many :messages, dependent: :destroy
    
    def is_room?(someone)
        entries = someone.entries
        if entries.nil?
            return false
        else
            entries.each do |room|
            end
        end
    end
end
