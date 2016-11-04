module Calculator

  def calculate_standard_deviation(flamboyance, average, total_number)
    numerator = flamboyance.map do |flamingo|
      (flamingo - average)**2
    end.reduce(:+)
    denominator = total_number - 1
    Math::sqrt(numerator / denominator)
  end
end
