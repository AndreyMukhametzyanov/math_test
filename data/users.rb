# frozen_string_literal: true

require_relative 'db_initialization'
require 'singleton'

class Users
  include Singleton

  def create(name, age, statistic)
    if name.nil? && age.nil? && statistic.nil?
      false
    else
      db_connection.execute('INSERT INTO users(name,age,statistic) VALUES(?,?,?)', name, age, statistic)
      true
    end
  rescue StandardError => e
    puts e.message
    false
  end

  def index
    result = db_connection.execute('SELECT * FROM users')
    result.map do |el|
      {
        id: el[0],
        name: el[1],
        age: el[2],
        statistic: el[3]
      }
    end
  rescue StandardError => e
    puts e.message
    []
  end

  def find_by_name(name)
    unless name.nil?
      result = db_connection.execute('SELECT * FROM users WHERE name = ? LIMIT 1', name)
      if result.empty?
        nil
      else
        id, name, age, statistic = result.first
        { id: id, name: name, age: age, statistic: statistic }
      end
    end
  rescue StandardError => e
    puts e.message
  end

  def statistic_render(finish_time, start_time, correct_answers, incorrect_answers, number_of_examples)
    result_time = (finish_time - start_time).round(2)
    average_time = result_time / number_of_examples
    "Результат:\nКоличество правильно решённых примеров: #{correct_answers}\nОбщее количество примеров: #{incorrect_answers}\nСреднеее время решения одного примера: #{average_time}\nОбщее время решения: #{result_time}"
  end

  def statistic_to_line(string)
    string.to_s.split("\n").join(' ')
  end

  def self.method_missing(method_name, *arguments, &block)
    if instance.respond_to?(method_name)
      instance.send(method_name, *arguments)
    else
      super
    end
  end

  def self.respond_to_missing?(method_name)
    instance.respond_to?(method_name) || super
  end

  private

  def db_connection
    @db_connection ||= SQLite3::Database.open('secret_users.db')
  end
end
