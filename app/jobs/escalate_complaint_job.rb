class EscalateComplaintJob < ApplicationJob
  queue_as :default

  def perform(complaint)
    # Do something later
    return if complaint.escalated?
    
    complaint.escalate_to_executive_dean_2!
  end
end
