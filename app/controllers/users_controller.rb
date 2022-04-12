class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def index
  end
  
  def show
    @users = User.all
  end
  
  def new
  end
  
  
  
end
