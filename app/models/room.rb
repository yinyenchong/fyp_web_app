class Room < ApplicationRecord
    
    has_many :messages
    has_many :participants, dependent: :destroy
    
    validates_uniqueness_of :name
    
    after_create_commit { broadcast_if_public }
    
    scope :public_rooms, -> {
        
        where(is_private: false)
    }
    
    
    def broadcast_if_public
    
        broadcast_append_to "rooms" unless self.is_private
        #broadcast_latest_message
    
    end
    
    
    def self.create_private_room(users, room_name)
        single_room = Room.create(name: room_name, is_private: true)
        
        users.each do |user|
          Participant.create(user_id: user.id, room_id: single_room.id)
        end
        
        single_room
    end
    
    def participant?(room, user)
        room.participants.where(user: user).exists?
        #Participant.where(user_id: user_id, room_id: room.id).exists?
    end
    
    def broadcast_latest_message
        last_message = latest_message
    
        return unless last_message
    
        room_target = "room_#{id} last_message"
        user_target = "room_#{id} user_last_message"
        sender = Current.user.eql?(last_message.user) ? Current.user : last_message.user
    
        broadcast_update_to('rooms',
                            target: room_target,
                            partial: 'rooms/last_message',
                            locals: {
                              room: self,
                              user: last_message.user,
                              last_message: last_message
                            })
                            
        broadcast_update_to('rooms',
                            target: user_target,
                            partial: 'users/last_message',
                            locals: {
                              room: self,
                              user: last_message.user,
                              last_message: last_message,
                              sender: sender
                            })
    end
    
end


