# frozen_string_literal: true

class StatisticRender
  def statistic_render(finish_time, start_time, correct_answers, incorrect_answers, number_of_examples)
    result_time = (finish_time - start_time).round(2)
    average_time = result_time / number_of_examples
    puts "Результат:\n
Количество правильно решённых примеров: #{correct_answers}\n
Общее количество примеров: #{incorrect_answers}\n
Среднеее время решения одного примера: #{average_time}\n
Общее время решения: #{result_time}"
  end
end
