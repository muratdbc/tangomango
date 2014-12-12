require 'geokit'
class Event < ActiveRecord::Base

 def self.getEventsByDate(date)
    eventCoordinates=Event.where(date: date).pluck(:latitude,:longtitude)
    eventCoordinates.flatten!
    p eventCoordinates
 end


 def createWithGeo(params)
    latLongArray=createFullAddress(params)
    p params[:state]
    Event.create(address: params[:address],
                city: params[:city],
                area: params[:area],
                event_type: params[:event_type],
                date: params[:date],
                state: params[:state],
                title: params[:title],
                longtitude: latLongArray[1],
                latitude: latLongArray[0])
 end
 def createFullAddress(params)
  full_address=[params[:address],params[:city],params[:state]].join(",")
  p full_address
  runGeocokit(full_address)
 end
 def runGeocokit(fullAddress)
  address=Geokit::Geocoders::GoogleGeocoder.geocode fullAddress
  address.ll.split(",")
 end

end
