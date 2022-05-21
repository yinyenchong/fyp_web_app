class StaticPagesController < ApplicationController
  
  def home
  end
  
  def complaints_charts
    
    #authorize(nil, :complaints_charts?, policy: StaticPagesPolicy)
  end
  
  
end
