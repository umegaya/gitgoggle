require 'json'
require 'open3'

class Dispatcher
	DEBUG = true
	def initialize(data)
		@data = data
	end
	def sh(cmd, user)
		user = (user or ENV['USER'])
		cmd = "runuser -l #{user} -c \"#{cmd}\""
		if DEBUG then
			p "exec shell:#{cmd}"
		end
		Open3.popen3(cmd) do |i, o, e, t|
			i.close
			puts "stdout:" + o.read
			puts "stderr:" + e.read
		end
	end
	def run_hook_script(file, user)
		p "process #{file} with #{user ? user : "null"}"
		json = JSON.generate @data
		case File.extname(file)
		when ".rb"
			sh "ruby #{file} '#{json}'", user
		when ".sh"
			sh "#{file} '#{json}'", user
		else
			raise "invalid ext of file #{file}"
		end
	end
	def run_hook
		br = commit_branch
		p "run hook for branch #{br}"
		config = JSON.parse File.open("./settings.json").read
		config.each do |k,list|
			p "check #{k} and #{br} matched"
			next if /#{k}/ !~ br
			list.each do |v|
				path = File.expand_path(v[0])
				user = v[1]
				if File.file?(path) then
					run_hook_script path, user
				else
					p "iterate directory #{path}"
					Dir.foreach(path) do |f|
						p "check file : #{f}"
						next if f =~ /^\.+/
						p "#{f} is normal path"
						next if File.directory?(f)
						p "#{f} is not directory"
						run_hook_script (path + "/" + f), user
					end
				end
			end
		end 
	end
	def commit_branch
		return @data["ref"]
	end
end
