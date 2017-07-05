module FrequencyChartHelper
  def general_graph(series_name, y_values)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'How many orthography tokens are there per <b>'+series_name+'</b>?')
      f.tooltip(pointFormat: 'orthograhies: {point.percentage: .1f}%')
      f.plotOptions(pie: {allowPointSelect: true,
                          cursor: 'pointer'})
      f.series(name: series_name,
               colorByPoint: true,
               data: y_values,
               dataLabels: {style: {fontSize: '13px'}})
      f.chart(defaultSeriesType: 'pie',
              backgroundColor: '#FFF',
              borderWidth: 0,
              plotBackgroundColor: 'rgba(255, 255, 255, .9)',
              plotShadow: false,
              plotBorderWidth: 1)
      f.colors(['#A8754C', '#BC915C', '#D5AA75', '#F2C793', '#FFD49F', '#FFD7A5', '#FFC1A5', '#F2B193', '#D59375', '#BC7A5C' ])
      # f.colors(['#338A2E', '#95a5a6', '#5AAC56', '#496D89', '#718EA4', '#294F6D', '#bdc3c7'])
    end
  end
end
