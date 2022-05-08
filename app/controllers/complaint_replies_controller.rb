class ComplaintRepliesController < ApplicationController
  before_action :set_complaint_reply, only: [:show, :edit, :update, :destroy]
  before_action :set_complaint
  

  # GET /complaint_replies
  # GET /complaint_replies.json
  def index
    @complaint_replies = ComplaintReply.all
  end

  # GET /complaint_replies/1
  # GET /complaint_replies/1.json
  def show
  end

  # GET /complaint_replies/new
  #def new
    #@complaint_reply = ComplaintReply.new
    
  #end

  # GET /complaint_replies/1/edit
  #def edit
  #end

  # POST /complaint_replies
  # POST /complaint_replies.json
  def create
    #@complaint = Complaint.find(params[:post_id])
   
    #@complaint_reply = ComplaintReply.new(complaint_reply_params)
    
    @complaint_reply = @complaint.complaint_replies.create(complaint_reply_params)
    @complaint_reply.user = current_user
    
    

    respond_to do |format|
      if @complaint_reply.save
        #format.html { redirect_to @complaint_reply, notice: 'Reply to complaint successful.' }
          
        format.html { redirect_to @complaint, notice: 'Reply successful.' }
        format.json { render :show, status: :created, location: @complaint_reply }
      else
        format.html { render :new }
        format.json { render json: @complaint_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /complaint_replies/1
  # PATCH/PUT /complaint_replies/1.json
  def update
    respond_to do |format|
      if @complaint_reply.update(complaint_reply_params)
        format.html { redirect_to @complaint_reply, notice: 'Reply to complaint successfully updated.' }
        format.json { render :show, status: :ok, location: @complaint_reply }
      else
        format.html { render :edit }
        format.json { render json: @complaint_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /complaint_replies/1
  # DELETE /complaint_replies/1.json
  def destroy
   
    @complaint_reply = @complaint.complaint_replies.find(params[:id])
    
    @complaint_reply.destroy
    
    respond_to do |format|
      
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_complaint_reply
      @complaint_reply = ComplaintReply.find(params[:id])
    end
    
    def set_complaint
      @complaint = Complaint.find(params[:complaint_id])
    end

    # Only allow a list of trusted parameters through.
    def complaint_reply_params
      #params.require(:complaint_reply).permit(:reply, :complaint_id)
      params.require(:complaint_reply).permit(:reply)
    end
end
