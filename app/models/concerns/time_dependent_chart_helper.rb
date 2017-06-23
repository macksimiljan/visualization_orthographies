module TimeDependentChartHelper
  def time_dependent_graph(x_axis, greek_values, coptic_values, ortho_values, source_values)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'How many entities are attested in sources at a particular time?')
      f.xAxis(categories: x_axis,
              title: {text: 'Time (start of the interval)', margin: 30, style: {fontSize: '20px'}},
              labels: {style: {fontSize: '17px'}})
      f.series(name: 'Greek Lemma',
               yAxis: 0,
               data: greek_values)
      f.series(name: 'Coptic Sublemma',
               yAxis: 0,
               data: coptic_values)
      f.series(name: 'Orthography',
               yAxis: 0,
               data: ortho_values)
      f.series(name: 'Source',
               yAxis: 0,
               data: source_values)
      f.yAxis(title: {text: 'Frequency', margin: 42, style: {fontSize: '20px'}},
              labels: {style: {fontSize: '17px'}})
      f.legend(align: 'right',
               verticalAlign: 'top',
               y: 75,
               x: -50,
               layout: 'vertical',
               itemStyle: {fontSize: '15px'},
               itemHoverStyle: {color: 'rgb(242,241,245)'})
      f.chart(defaultSeriesType: 'line',
                   backgroundColor: '#FFF',
                   borderWidth: 0,
                   plotBackgroundColor: 'rgba(255, 255, 255, .9)',
                   plotShadow: false,
                   plotBorderWidth: 1)
      f.colors(['rgb(162, 0, 37)', 'rgb(227, 200, 0)', 'rgb(220, 104, 5)', 'rgb(235, 20, 0)'])
    end
  end
end