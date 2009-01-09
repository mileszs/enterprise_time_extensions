module EnterpriseTimeExtensions
  module ClassMethods
    def next_sunday
      timeobj = Time.local(Time.now.year, Time.now.month, Time.now.day, 0) # Today at midnight
      timeobj += 60*60*24 until timeobj.wday == 0
      timeobj # Should now be next Sunday at midnight
    end

    def nth_wday(n, wday, month, year)
      if (!n.between? 1,5) ||
         (!wday.between? 0,6) ||
         (!month.between? 1,12)
        raise ArgumentError
      end
      t = Time.local year, month, 1
      first = t.wday
      if first == wday
        fwd = 1
      elsif first < wday
        fwd = wday - first + 1
      elsif first > wday
        fwd = (wday+7) - first + 1
      end
      target = fwd + (n-1)*7
      begin
        t2 = Time.local year, month, target
      rescue ArgumentError
        return nil
      end
      t2
    end
  end

  def after_hours?
    result = true
    # M-F, 8am to 6pm are business hours
    if (1..5).include?(self.wday) && (8..17).include?(self.hour)
      result = false
    end
    # unless it's a holiday!
    if self.holiday?
      result = true
    end
    result
  end

  def holiday?
    unless new_years_day? ||
       mlk_jr_day? ||
       memorial_day? ||
       independence_day? ||
       labor_day? ||
       thanksgiving? ||
       christmas_day?
      return false
    end
    true
  end

  def new_years_day?
    return false unless self.yday == 1
    true
  end

  def mlk_jr_day?
    return false unless self.yday == Time.nth_wday(3,1,1,self.year).yday
    true
  end

  def memorial_day?
    last_day_of_month = Time.local(self.year, 5, 31)
    if last_day_of_month.wday == 0
      d = 25
    else
      d = last_day_of_month.mday - last_day_of_month.wday + 1
    end
    return false unless self.yday == Time.local(self.year, 5, d).yday
    true
  end

  def independence_day?
    return false unless self.month == 7 && self.mday == 4
    true
  end

  def labor_day?
    return false unless self.yday == Time.nth_wday(1,1,9,self.year).yday
    true
  end

  def thanksgiving?
    return false unless self.yday == self.class.nth_wday(4,4,11,self.year).yday
    true
  end

  def christmas_day?
    return false unless self.month == 12 && self.mday == 25
    true
  end
end

Time.class_eval do
  include EnterpriseTimeExtensions
  extend EnterpriseTimeExtensions::ClassMethods
end
