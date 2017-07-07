class BasicStatisticsFrequency

  def value_frequency_distribution(attribute, percentage)
    cleaned_result = []
    sum = 0
    others = 0
    result_set_for(attribute).each {|datum| sum += datum['y']}
    result_set_for(attribute).each do |datum|
      datum['name'] ||= 'not specified'
      if relevant?(sum, datum['y'], percentage)
        cleaned_result.append(datum)
      else
        others += datum['y']
      end
    end
    cleaned_result.append('name' => 'others', 'y' => others) unless others.zero?
  end

  private

  def result_set_for(attribute)
    case attribute
    when 'dialect'
      ActiveRecord::Base.connection.exec_query(Queries::OrthographyFrequency.sql_frequency_dialect)
    when 'text'
      ActiveRecord::Base.connection.exec_query(Queries::OrthographyFrequency.sql_frequency_text)
      else
        ActiveRecord::Base.connection.exec_query(Queries::OrthographyFrequency.sql_frequency(attribute))
    end

  end

  def relevant?(total, frequency, percentage)
    frequency >= percentage * total
  end
end