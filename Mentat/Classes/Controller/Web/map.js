$(function () {
  
  // Initiate the chart
  $('#container').highcharts('Map', {
                             title: {
                             text: 'Employment by District'
                             },
                             mapNavigation: {
                             enabled: true,
                             buttonOptions: {
                             verticalAlign: 'bottom'
                             }
                             },
                             
                             colorAxis: {
                             min: 0
                             },
                             
                             series: [{
                                      data: %@,
                                      mapData: Highcharts.maps['countries/bn/bn-all'],
                                      joinBy: 'hc-key',
                                      allAreas: false,
                                      name: 'Employment Data',
                                      states: {
                                      hover: {
                                      color: '#BADA55'
                                      }
                                      },
                                      dataLabels: {
                                      enabled: true,
                                      format: '{point.name}'
                                      }
                                      }]
                             });
  
  });