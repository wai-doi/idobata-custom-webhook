desc 'Send message to idobata.'
task :send_message do
  message = 'Hello World! :smile:'
  `curl --data-urlencode "source=#{message}" #{ENV['END_POINT_URL']}`
end
