require 'open-uri'
require 'json'

class WeatherReport
  def initialize(forecast)
    @date_label = forecast['dateLabel']
    @date = Date.parse(forecast['date'])
    @telop = forecast['telop']
  end

  def message
    "#{@date_label} #{date_str}の天気 #{@telop} #{emoji}"
  end

  private

  def date_str
    "#{@date.strftime("%-m月%-d日")}(#{day_of_week})"
  end

  def day_of_week
    %w(日 月 火 水 木 金 土)[@date.wday]
  end

  def emoji
    @telop.scan(Regexp.union(*weather_emoji.keys))
      .map { |str| weather_emoji[str] }
      .join(' ')
  end

  def weather_emoji
    {
      '晴' => ':sunny:',
      '曇' => ':cloud:',
      '雨' => ':umbrella:',
      '雪' => ':snowman:'
    }
  end
end

desc 'Send weather report.'
task :send_weather_report do
  url = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
  response = URI.open(url)
  json = JSON.parse(response.read)
  message = json['forecasts']
    .map { |forecast| WeatherReport.new(forecast).message }
    .join("\n")
  IdobataCustomWebhook.send_message(message)
end
