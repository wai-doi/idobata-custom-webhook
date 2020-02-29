desc 'Send hello world to idobata.'
task :send_hello_world do
  message = 'Hello World! :smile:'
  IdobataCustomWebhook.send_message(message)
end
