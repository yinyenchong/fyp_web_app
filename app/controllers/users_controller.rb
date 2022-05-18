class UsersController < ApplicationController
  
  #before_action :logged_in_user, only: [:index, :edit, :update]
  #before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, only: [:index, :show, :edit, :update, :destroy]
  
  
  #after_action :verify_authorized, only: [:index, :show, :edit, :update, :destroy]
  
  def index
    @users = User.all
    
    
    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv }
    end
    
    authorize @users
    
    #if current_user.has_role? :admin
      #@users = User.order(created_at: :desc)
      #@users = User.all
    #else
      #redirect_to root_path, alert: 'not authorised'
    #end
  end
  
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end
  
  def show
    @user = User.find_by_id(params[:id])
    authorize @user
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
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
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
  
  
end
