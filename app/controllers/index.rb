get '/' do

  erb :calendar
end

get '/city/san-francisco' do

    Date.today.beginning_of_week.upto(Date.today.end_of_week) do |date|
    day=date.strftime('%A')
    instance_variable_set("@#{date.strftime('%A').downcase}", Event.where(:date=>date.to_s))
    end

    Date.today.next_week.upto(Date.today.next_week.end_of_week) do |date|
    day=date.strftime('%A')
    instance_variable_set("@next#{date.strftime('%A').downcase}", Event.where(:date=>date.to_s))
    end
    @firstWeek=Date.today.beginning_of_week
    @secondWeek=Date.today.next_week

  erb :san_francisco
end

get '/veunes/new' do
  erb :venue_new

end

post '/venues' do
  # redirect '/city/san-francisco'
  @event=Event.new
  if @event.createWithGeo(params)
    redirect  '/city/san-francisco'
  else
  end

end

# this is for Map
post '/show-venues' do
  content_type :json
  eventCoordinatesArray=Event.getEventsByDate(params[:date])
  eventCoordinatesArray.to_json

end

#this is for all the app
post '/show-all-venues' do
  # sleep(4)
  content_type :json
  allEvents=Event.order(:date).pluck(:date, :title)
  allEventsHash=Hash[allEvents.group_by(&:first)]
  allEventsHash.each { |key,value|  value.each { | index|   index.delete_at(0) } }
  allEventsHash.each { | key,value| p  value.flatten!() }
  events_hash={}
  allEventsHash.each_with_index {  | (key,value),index |   events_hash[index]=value  }
  events_hash.to_json
end
post '/area-cat' do
   content_type :json
   allEvents=Event.order(:date,:id).where(:date=>Date.today.beginning_of_week..Date.today.next_week.end_of_week).pluck(:address,:area,:event_type)
   # allEvents=Event.where(:date=>Date.today.beginning_of_week).pluck(:address,:area,:event_type)
   allEventsHash=Hash[allEvents.group_by(&:first)]
  allEventsHash.each { |key,value|  value.each { | index|   index.delete_at(0) } }
  allEventsHash.each { | key,value| p  value.flatten!() }
  events_hash={}
  allEventsHash.each_with_index {  | (key,value),index |   events_hash[index]=value  }
  events_hash.to_json
end