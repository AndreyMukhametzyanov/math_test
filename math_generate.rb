# frozen_string_literal: true

class MathGenerate
  def generate
    a = rand(101)
    b = rand(101)
    sign = %w[+ - * /].sample
    if a > b
      [a, sign, b]
    else
      [b, sign, a]
    end
  end

  def solution(example)
    eval(example.join)
  end

  def error_rate?(example)
    actual_float = example[0].to_f / example[2]
    expected_float = (example[0].to_f / example[2]).round(2)
    delta = 0.1
    (expected_float - actual_float).abs <= delta
  end

  def number_check(number)
    true if number >= 10 && number <= 100
  end
end
