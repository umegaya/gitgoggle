require 'sinatra'
require 'json'
require './dispatcher.rb'

get "/ping" do
	"alive"
end
post "/" do
	request.body.rewind
	raise "format error" unless request.body.read =~ /payload=(.*)$/
	data = JSON.parse URI.decode $1
	# p "json = #{data}"
	dp = Dispatcher.new(data)
	dp.run_hook
end

