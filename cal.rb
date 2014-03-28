require 'bundler/setup'
require 'date'
require 'time'

Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def menu
puts 'Welcome to the calendar'
puts "type 'a' to add an event"
puts "type 'e' to edit an event"
puts "type 'ls' to list upcoming events"
input = gets.chomp
case input
  when 'a'
  add_event
  when 'e'
  edit_event
  when 'ls'
  list_events
  else
    'later!'
  end
end

def add_event
  puts 'please type the events description'
  d = gets.chomp
  puts 'please type its location'
  l = gets.chomp
  puts 'start date?'
  s = gets.chomp
  start_date = Date.parse(s)
  puts 'end date?'
  e = gets.chomp
  e = Date.parse(e)
  puts 'time of the event, please enter in military time!'
  t = gets.chomp
  ts = Date.parse(s.to_s[0..10])
  t = Time.parse(t, ts)
  if Event.create(:description => d, :location => l, :start => start_date, :end => e, :time => t).valid? == false
    puts 'you created an invalid event chump!'
  else
    puts 'ok here are the upcoming events'
    list_events
  end
  menu
end

def edit_event
  calendar = Event.all.each_with_index { |event, index| puts "#{index+1}. #{event.time} #{event.description}"}
  puts "Choose the Event you want by index"
  user_selection = gets.chomp.to_i
  selected_event = calendar[user_selection-1]
  puts "Do you want to edit 'e' or delete 'd' the following event: '#{selected_event.description}"
  user_input = gets.chomp
  case user_input
  when 'e' then update_event(selected_event)
  when 'd' then delete_event(selected_event)
  else
    edit_event
  end
end

def delete_event(selected_event)
    selected_event.destroy
    puts "You have removed '#{selected_event.description}' from your Calendar"
    menu
end

def update_event(selected_event)
  puts 'please type the events description'
  d = gets.chomp
  puts 'please type its location'
  l = gets.chomp
  puts 'start date?'
  s = gets.chomp
  puts 'end date?'
  e = gets.chomp
  puts 'time of the event'
  t = gets.chomp
  Event.update(:description => d, :location => l, :start => s, :end => e, :time => t)
end

def list_events
  events = Event.where(:start =>(Date.yesterday..Date.new(2051) ) )
  events.each do |event|
    puts event.description
  end
end

menu
