class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: [:complaints_charts]
  
  
  def home
  end
  
  def complaints_charts
    #authorize(nil, :complaints_charts?, policy: StaticPagesPolicy)
    authorize :static_page, :complaints_charts?
    
  end
  
  
end
