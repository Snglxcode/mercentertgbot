require 'active_record'
require 'yaml'

db_config = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(db_config['development'])

class CreateNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :numbers do |t|
      t.integer :value
      t.date :saved_on
      t.timestamps
    end
  end
end

CreateNumbers.new.change