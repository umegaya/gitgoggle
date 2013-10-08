require 'json'

commit = JSON.parse ARGV[0]

p "commit hook to #{commit["ref"]}:runtest"
