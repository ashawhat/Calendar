require 'date'
class Event < ActiveRecord::Base

validates :description, :location, :presence => true, :length => {:maximum => 35, :minimum => 2}



  def self.yearview(year_choice)
    day1 = '01-01-'+year_choice
    d = Date.parse(day1)
    Event.where(:start => d.beginning_of_year..d.end_of_year)
  end

  def self.monthview(month_choice)
    day1ofmonth = '01-'+month_choice+'-'+Time.now.year.to_s
    d = Date.parse(day1ofmonth)
    Event.where(:start => d.beginning_of_month..d.end_of_month)
  end

  def self.dayview(day_choice)
    day = day_choice+'-'+Time.now.month.to_s+'-'+Time.now.year.to_s
    d = Date.parse(day)
    Event.where(:start => d.yesterday...d.tomorrow)
  end

  def self.weekview
    day = Date.today
    # puts Event.all.first.start
    # puts day
    Event.where(:start => day...(day+6))
  end


end
