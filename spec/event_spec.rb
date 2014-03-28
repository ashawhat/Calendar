require 'spec_helper'

describe Event do
  it { should ensure_length_of(:description).is_at_least(2) }
  it { should ensure_length_of(:description).is_at_most(35) }
  it { should ensure_length_of(:location).is_at_least(2) }
  it { should ensure_length_of(:location).is_at_most(35) }

  describe 'Event.yearview' do
    it 'should only let you view events in the specifed year' do
      e = Event.create(:description => 'spyders party', :location => 'roof of spyders house', :start => '02-02-2015', :end => '01-02-2015', :time => '16:00')
      e1 = Event.create(:description => 'dan party', :location => 'roof of dans house', :start => '01-01-2017', :end => '01-02-2015', :time => '16:00')
      Event.yearview('2015').should eq [e]
    end
  end

  describe 'Event.monthview' do
    it 'should only let you view events in the specifed month' do
      e = Event.create(:description => 'spyders party', :location => 'roof of spyders house', :start => '02-02-2014', :end => '01-02-2015', :time => '16:00')
      e1 = Event.create(:description => 'dan party', :location => 'roof of dans house', :start => '01-01-2017', :end => '01-05-2015', :time => '16:00')
      Event.monthview('02').should eq [e]
    end
  end

  describe 'Event.dayview' do
    it 'should only let you view events in the specifed day' do
      e = Event.create(:description => 'spyders party', :location => 'roof of spyders house', :start => '02-03-2014', :end => '01-02-2015', :time => '16:00')
      e1 = Event.create(:description => 'dan party', :location => 'roof of dans house', :start => '01-01-2017', :end => '01-05-2015', :time => '16:00')
      puts "This is the starting date for the dayview test: #{e.start.month}"
      Event.dayview('02').should eq [e]
    end
  end

  describe 'Event.weekview' do
    it 'should only let you view events in the specifed week' do
      e = Event.create(:description => 'spyders party', :location => 'roof of spyders house', :start => '30-03-2014', :end => '01-02-2015', :time => '16:00')
      e1 = Event.create(:description => 'spyders party', :location => 'roof of spyders house', :start => '30-03-2015', :end => '01-02-2015', :time => '16:00')
      puts "This is the starting date for the weekview test: #{e.start}"
      Event.weekview.should eq [e]
    end
  end

end
