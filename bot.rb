require 'telegram/bot'
require 'sinatra'
require 'yaml'
require_relative 'models/number'

token = ENV['TG_TOKEN']

db_config = YAML.load_file('config/database.yml')
db_config['development']['username'] = ENV['DB_USER']
db_config['development']['password'] = ENV['DB_PASSWORD']
ActiveRecord::Base.establish_connection(db_config['development'])

Thread.new do
  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      case message.text
      when /^\d+$/
        number = message.text.to_i
        num = Number.where(saved_on: Date.today).first_or_create
        num.value =  number
        num.save
        bot.api.send_message(chat_id: message.chat.id, text: "Сумма за #{Date.today.strftime('%d.%m')} сохранена!")
      when 'итог', 'Итог'
        today = Date.today
        start_of_current_month = today.beginning_of_month
        end_of_current_month = today.end_of_month

        start_of_previous_month = (today - 1.month).beginning_of_month
        end_of_previous_month = (today - 1.month).end_of_month

        # Сумма за текущий месяц
        sum_current_month = Number.sum_for_period(start_of_current_month, end_of_current_month)

        # Сумма за прошлый месяц
        sum_previous_month = Number.sum_for_period(start_of_previous_month, end_of_previous_month)

        # Формируем ответ
        response = <<~TEXT
          Сумма прошлый месяц (#{end_of_previous_month.strftime('%m.%Y')}): #{sum_previous_month}, (35% - #{(sum_previous_month*0.35).to_i})
          Сумма текущий месяц (#{end_of_current_month.strftime('%m.%Y')}): #{sum_current_month}, (35% - #{(sum_current_month*0.35).to_i})
        TEXT

        # Отправляем ответ
        bot.api.send_message(chat_id: message.chat.id, text: response)
      else
        bot.api.send_message(chat_id: message.chat.id, text: "Пожалуйста, введите сумму.")
      end
    end
  end
end

set :port, ENV['PORT'] || 3000

get '/' do
  'Telegram Bot is running!'
end