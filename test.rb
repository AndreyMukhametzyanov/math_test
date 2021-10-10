require_relative 'math_generate'
require_relative './data/users'

EXAMPLE = MathGenerate.new

correct_answers = 0
incorrect_answers = 0
counter = 1

puts 'Введите ваше имя'
name = gets.chomp.to_s
puts 'Введите ваш возраст'
age = gets.chomp.to_s
puts 'Введите желаемое количество примеров'
user_examples = gets.chomp.to_i

NUMBER_OF_EXAMPLES = user_examples #Костыль
# потому что при уменьшении счетчика
# данная переменная бы стала 0 и я не смог ее взять статистику

if EXAMPLE.number_check(user_examples)
  START_TIME = Time.now
  while user_examples > 0
    primer = EXAMPLE.generate
    puts "#{counter}) #{primer.join(" ")} = ?"
    user_choise = gets.to_i

    if primer[1] == '/'
      if EXAMPLE.error_rate?(primer) && user_choise == EXAMPLE.solution(primer)
        correct_answers += 1
      else
        incorrect_answers += 1
      end
    else
      if user_choise == EXAMPLE.solution(primer)
        correct_answers += 1
      else
        incorrect_answers += 1
      end
    end
    user_examples -= 1
    counter += 1
  end

  FINISH_TIME = Time.now

  statistic = Users.statistic_render(FINISH_TIME, START_TIME, correct_answers, incorrect_answers, NUMBER_OF_EXAMPLES)
  Users.create(name, age, Users.statistic_to_line(statistic))
else
  puts 'Вы ввели некоректное количество примеров'
end
puts 'Спасибо'
puts "В базе данных:"
puts Users.index

