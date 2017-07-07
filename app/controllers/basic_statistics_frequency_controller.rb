class BasicStatisticsFrequencyController < ApplicationController
  include FrequencyChartHelper

  def index
    parameters = read_params
    @chart_frequency00 = create_general_graph(parameters[:attribute00], parameters[:percentage00])
    @chart_frequency01 = create_general_graph(parameters[:attribute01], parameters[:percentage01])
    @chart_frequency10 = create_general_graph(parameters[:attribute10], parameters[:percentage10])
    @chart_frequency11 = create_general_graph(parameters[:attribute11], parameters[:percentage11])
  end

  private

  def create_general_graph(attribute, params)
    statistics = BasicStatisticsFrequency.new
    values = statistics.value_frequency_distribution(attribute, params)
    general_graph(attribute, values)
  end

  def read_params
    p = {}
    p[:percentage00] = params[:percentage00].nil? ? 0.04 : params[:percentage00].to_f
    p[:percentage01] = params[:percentage01].nil? ? 0.04 : params[:percentage01].to_f
    p[:percentage10] = params[:percentage10].nil? ? 0.04 : params[:percentage10].to_f
    p[:percentage11] = params[:percentage11].nil? ? 0.04 : params[:percentage11].to_f
    p[:attribute00] = params[:attribute00].nil? ? 'dialect' : params[:attribute00]
    p[:attribute01] = params[:attribute01].nil? ? 'text' : params[:attribute01]
    p[:attribute10] = params[:attribute10].nil? ? 'typo_broad' : params[:attribute10]
    p[:attribute11] = params[:attribute11].nil? ? 'dating_start' : params[:attribute11]
    p
  end
end