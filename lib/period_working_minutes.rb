class Escalation
    
  class PeriodWorkingMinutes
      
    def initialize(start_time, end_time, complaint, biz)
      @start_time   = start_time
      @end_time     = end_time
      @complaint    = complaint
      @biz          = biz
    end

    def period_working_minutes
      @biz.within(timeframe_start, timeframe_end).in_minutes
    end

    private

        def timeframe_start
          [@complaint.created_at, @start_time]
        end
    
        def timeframe_end
          [@complaint.close_at, @end_time]
        end
        
  end
end