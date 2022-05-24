class Room < ApplicationRecord
    
    has_many :messages
    
    validates_uniqueness_of :name
    
    after_create_commit { broadcast_append_to "rooms" }
    
    scope :public_rooms, -> {
        
        where(is_private: false)
    }
    
end


