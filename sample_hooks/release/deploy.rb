require 'json'
require 'uri'

p "json = #{ARGV[0]}"

commit = JSON.parse URI.decode ARGV[0]

cmd = "#{File.expand_path(File.dirname(__FILE__))}/scripts/deploy.sh #{commit["after"]}"

p "exec command = #{cmd}"

exec(cmd)

