# Gemfile
source 'https://rubygems.org'

# Основные гемы
gem 'telegram-bot-ruby', '~> 0.15' # Для работы с Telegram API
gem 'activerecord', '~> 7.0'      # Для работы с базой данных
gem 'sqlite3', '~> 1.4'            # Драйвер для SQLite (или другой базы данных, например, pg для PostgreSQL)

# Гемы для разработки и тестирования
group :development do
  gem 'rake', '~> 13.0'            # Для выполнения задач (например, миграций)
  gem 'pry', '~> 0.14'             # Для отладки
end

group :test do
  gem 'rspec', '~> 3.10'           # Для тестирования (если нужно)
  gem 'factory_bot', '~> 6.2'      # Для создания тестовых данных
end