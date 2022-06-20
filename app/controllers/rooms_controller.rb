class RoomsController < ApplicationController
  
  #devise authentication
  before_action :authenticate_user!
  
  
  def index
    
    @room = Room.new
    @rooms = Room.public_rooms
    
    @users = User.all_except(current_user)
    
    #render 'index'
    
    authorize @rooms
    
  end
  
  def show
    @single_room = Room.find(params[:id])
     
    @room = Room.new
    @rooms = Room.public_rooms
    
    @message = Message.new
    
    
    @messages = @single_room.messages.order(created_at: :asc)
    
    #pagy_messages = @single_room.messages.includes(:user).order(created_at: :desc)
    #@pagy, messages = pagy(pagy_messages, items: 10)
    #@messages = messages.reverse

    
    
    @users = User.all_except(current_user)
    
    render 'index'
    
    authorize @room
    
  end
  
  def create
  
    @room = Room.create(name: params["room"]["name"])
    
    authorize @room
  
  end
  
  
  
  
end
