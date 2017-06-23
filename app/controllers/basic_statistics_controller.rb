class BasicStatisticsController < ApplicationController
  include FrequencyChartHelper
  include TimeDependentChartHelper

  def index
    @chart_time = create_time_dependent_graph
  end

  private

  def create_time_dependent_graph
    statistics = BasicStatisticsTime.new
    x_axis, greek_values = statistics.count_per_time('greek_lemma', params)
    _, coptic_values = statistics.count_per_time('coptic_sublemma', params)
    _, ortho_values = statistics.count_per_time('orthography', params)
    _, source_values = statistics.count_per_time('source', params)
    time_dependent_graph(x_axis, greek_values, coptic_values, ortho_values, source_values)
  end
end