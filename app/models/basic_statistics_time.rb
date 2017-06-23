class BasicStatisticsTime

  def count_per_time(measure='greek_lemma', parameters)
    read_params(parameters)
    histogram = aggregate(initial_histogram(measure))
    x_axis_categories = []
    y_axis_data = []
    Hash[histogram.sort].each_pair do |key, value|
      x_axis_categories.append(key)
      y_axis_data.append(value)
    end
    return x_axis_categories, y_axis_data
  end

  private

  def read_params(parameters)
    @interval = parameters[:interval].nil? ? 50 : parameters[:interval].to_i
    @min_year = parameters[:min_year].nil? ? 200 : parameters[:min_year].to_i
    @max_year = parameters[:max_year].nil? ? 1299 : parameters[:max_year].to_i
  end

  def initial_histogram(table)
    histogram = initialize_histogram
    result_set_for(table).each do |result|
      dating_start = result[1]
      dating_end = result[2]
      (dating_start..dating_end).each { |year| histogram[year] += 1 }
    end
    histogram
  end

  def initialize_histogram
    histogram = {}
    (@min_year..@max_year).each do |year|
      histogram[year] = 0
    end
    histogram
  end

  def result_set_for(table)
    case table
    when 'greek_lemma'
      ActiveRecord::Base.connection.execute(Queries::CountsPerTime.sql_greek_lemma)
    when 'coptic_sublemma'
      ActiveRecord::Base.connection.execute(Queries::CountsPerTime.sql_coptic_sublemma)
    when 'orthography'
      ActiveRecord::Base.connection.execute(Queries::CountsPerTime.sql_orthography)
    when 'source'
      ActiveRecord::Base.connection.execute(Queries::CountsPerTime.sql_source)
    else
      []
    end
  end

  def aggregate(histogram)
    histogram_aggr = {}
    @min_year.step(@max_year, @interval).each do |interval_start|
      histogram_aggr[interval_start] = 0
      (interval_start..(interval_start + @interval-1)).each do |year|
        histogram_aggr[interval_start] += histogram[year] unless histogram[year].nil?
      end
    end
    histogram_aggr
  end
end