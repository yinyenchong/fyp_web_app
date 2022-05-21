class EscalateJob < ApplicationJob
  queue_as :default

  def perform(complaint)
    # Do something later
    
    return if complaint.escalated_time > Time.current
    
    complaint.escalate_to_executive_dean!
  end
end
