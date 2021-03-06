

class ComplaintsController < ApplicationController
  before_action :set_complaint, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
 
  # GET /complaints
  # GET /complaints.json
  def index
    
    #@complaints = Complaint.all
    
    #@complaints = Complaint.filter_by_assignee_id(params[current_user])
    
    if current_user.has_role? :student 
      @complaints = Complaint.where(["user_id = ?", current_user])
    elsif current_user.has_role? :admin
      @complaints = Complaint.all
      
      respond_to do |format|
        format.html
        format.csv { send_data @complaints.to_csv, filename: "complaints-#{Date.today}.csv" }
      end
      
    elsif current_user.has_role? :executive_dean
      @complaints = Complaint.where("assignee_id = ? OR escalated_to_user_id = ?", current_user, current_user) 
    else  
      @complaints = Complaint.where(["assignee_id = ?", current_user])
    end
    
    # this works when not being called as a job
    Complaint.escalate_to_executive_dean_by_index!
    
    authorize @complaints
    
  end
 
  # GET /complaints/1
  # GET /complaints/1.json
  def show
    @complaint_replies = @complaint.complaint_replies
    EscalateJob.perform_now(@complaint)
   
  end
 
 
 
  # GET /complaints/new
  def new
    @complaint = Complaint.new
    authorize @complaint
  end
 
  # GET /complaints/1/edit
  def edit
  end
 
  # POST /complaints
  # POST /complaints.json
  def create
    @complaint = Complaint.new(complaint_params)
    @complaint.user = current_user
    
    # do not stick the escalate job in create. Why? Because you're trying to compare the time difference to escalate the complaint...
    # when it hasn't even been created yet
    # no time travelling allowed
    
    #@complaint.escalate_to_executive_dean
    
    #EscalateJob.perform_now(@complaint)
    
    
    
    authorize @complaint
 
    respond_to do |format|
      if @complaint.save
        format.html { redirect_to @complaint, notice: 'Complaint was successfully created.' }
        format.json { render :show, status: :created, location: @complaint }
      else
        format.html { render :new }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # PATCH/PUT /complaints/1
  # PATCH/PUT /complaints/1.json
  def update
    respond_to do |format|
      if @complaint.update(complaint_params)
        
        #EscalateJob.set(wait: 1.minutes).perform_later(@complaint)
        
        EscalateJob.perform_now(@complaint)
        
        format.html { redirect_to @complaint, notice: 'Complaint was successfully updated.' }
        format.json { render :show, status: :ok, location: @complaint }
      else
        format.html { render :edit }
        format.json { render json: @complaint.errors, status: :unprocessable_entity }
      end
    end
  end
 
  # DELETE /complaints/1
  # DELETE /complaints/1.json
  def destroy
    @complaint.destroy
    respond_to do |format|
      format.html { redirect_to complaints_url, notice: 'Complaint was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint
      @complaint = Complaint.find(params[:id])
      authorize @complaint
    end
    
    
    def update_completed_status
      @complaint = Complaint.find(params[:id])
      @complaint.update_attribute(:completed, true)
      @complaint.update_attribute(:completed, DateTime.now)
      
      format.html { redirect_to @complaint, notice: 'Complaint closed.' }
      format.json { render :show, status: :ok, location: @complaint }
      
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def complaint_params
      params.require(:complaint).permit(:title, :body, :user_id, :assignee_id, :complaintfile, 
                                        :completed, :escalated, :escalated_to_user_id, :escalated_time, :last_reply_at,
                                        :completed_time)
    end
    
    
end
