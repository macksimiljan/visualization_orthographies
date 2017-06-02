class BasicStatisticsController < ApplicationController
  def index
    statistics = BasicStatistics.new
    interval = params[:interval].nil? ? 50 : params[:interval].to_i
    x_axis_categories, y_axis_data0 = statistics.count_per_time('greek_lemma', interval)
    _, y_axis_data1 = statistics.count_per_time('coptic_sublemma', interval)
    _, y_axis_data2 = statistics.count_per_time('orthography', interval)
    _, y_axis_data3 = statistics.count_per_time('source', interval)
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'How many entities are attested in sources at a particular time?')
      f.xAxis(categories: x_axis_categories,
              title: {text: 'Time (start of the interval)', margin: 30, style: {fontSize: '20px'}},
              labels: {style: {fontSize: '17px'}})
      f.series(name: 'Greek Lemma',
               yAxis: 0,
               data: y_axis_data0)
      f.series(name: 'Coptic Sublemma',
               yAxis: 0,
               data: y_axis_data1)
      f.series(name: 'Orthography',
               yAxis: 0,
               data: y_axis_data2)
      f.series(name: 'Source',
               yAxis: 0,
               data: y_axis_data3)
      f.yAxis(title: {text: 'Frequency', margin: 42, style: {fontSize: '20px'}},
              labels: {style: {fontSize: '17px'}})
      f.legend(align: 'right',
               verticalAlign: 'top',
               y: 75,
               x: -50,
               layout: 'vertical',
               itemStyle: {fontSize: '15px'},
               itemHoverStyle: {color: '#FFF'})
      f.chart(defaultSeriesType: 'column',
              backgroundColor: 'rgb(242,241,245)',
              borderWidth: 0,
              plotBackgroundColor: 'rgba(255, 255, 255, .9)',
              plotShadow: false,
              plotBorderWidth: 1)
      f.colors(['rgb(162, 0, 37)', 'rgb(227, 200, 0)', 'rgb(220, 104, 5)', 'rgb(235, 20, 0)'])
    end
  end
end