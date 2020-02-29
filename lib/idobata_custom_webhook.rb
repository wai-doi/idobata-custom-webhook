module IdobataCustomWebhook
  module_function

  def send_message(message)
    `curl --data-urlencode "source=#{message}" #{ENV['END_POINT_URL']}`
  end
end
