require 'active_record'

class Number < ActiveRecord::Base

  def self.sum_for_period(start_date, end_date)
    where(saved_on: start_date..end_date).sum(:value)
  end
  
end