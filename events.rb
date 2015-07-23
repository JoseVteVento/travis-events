require 'rubygems'
require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/event.db")

class Event
	include DataMapper::Resource
	property :id, Serial
	property :title, Text, :required => true
	property :subject, Text, :required => true
	property :speaker, Text, :required => true
	property :place, Text, :required => true
	property :date, Text, :required => true
	property :complete, Boolean, :required => true, :default => false
end

DataMapper.finalize.auto_upgrade!

get '/' do 
	@event = Event.all :order => :id.desc
	@title = "Events"
	erb :home
end

put '/' do
	@event = Event.all :order => :id.desc
	@title = "Events"
	erb :home
end

post '/' do
	event = Event.new
	event.title = params[:name]
	event.subject = params[:subject]
	event.speaker = params[:speaker]
	event.place = params[:place]
	event.date = params[:date]
	event.save
	redirect '/'
end

#to able generate a invitation
get '/:id' do
	@event = Event.get params[:id]
	@title = "Generate invitation"
	erb :readmore
end

put '/:id/:n' do
	@event = Event.get params[:id]
	@title = "Generate invitation"
	@id_invitation = params[:n]
	erb :generate

end

get'/:id/generate/:n' do

	@event = Event.get params[:id]
	@title = "Generate invitation"
	@id_invitation = params[:n]								
	erb :generate
end








