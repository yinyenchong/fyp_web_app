class UsersController < ApplicationController
  
  #before_action :logged_in_user, only: [:index, :edit, :update]
  #before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  
  #after_action :verify_authorized, only: [:index, :show, :edit, :update, :destroy]
  
  
  def index
    
    @users = User.all
    #@user = User.find(params[:id])
    
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv"  }
    end
    
    authorize @users
    
  
  end
  
  def show_profile
    @user = User.find_by_id(params[:id])
    authorize @user
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end
  
  def show
    
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @rooms = Room.public_rooms
    @room = Room.new
    @room_name = get_name(@user, current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
    
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    
    authorize @user
    
    render 'rooms/index'
    
   
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    authorize @user
    
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      #redirect_to @user.sh
      redirect_to show_profile_user_path
    else
      render 'edit'
    end
    
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def set_user
      @user = User.find(params[:id])
    end


    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :avatar,  {role_ids: []} )
    end
    
    def get_name(user1, user2)
      
      user = [user1, user2].sort
      "private_#{user[0].id}_#{user[1].id}"
    end


    # Confirms a logged-in user.
    def logged_in_user
      unless user_signed_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      flash[:danger] = "Email or password incorrect."
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
