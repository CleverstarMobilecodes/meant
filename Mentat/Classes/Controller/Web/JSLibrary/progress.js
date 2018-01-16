$(function () {
  $('#container').highcharts({
                            chart: {
                                type: 'bar'
                             },
                             credits : {
                                enabled : false
                             },
                             title : {
                                text : null
                             },
                             xAxis : {
                                categories : [],
                                labels : {
                                    enabled : false
                                },
                                lineWidth : 0,
                                tickWidth : 0,
                                gridLineWidth : 0,
                                minorGridLineWidth : 0
                             },
                             yAxis : {
                                min : 0,
                                max : 100,
                                maxPadding : 0.1,
                                opposite : true,
                                labels : {
                                step : 10,
                                formatter : function() {
                                    return this.value + '%';
                                }
                                },
                                lineWidth : 0,
                                tickWidth : 0,
                                gridLineWidth : 0,
                                minorGridLineWidth : 0,
                                title : {
                                    text : null
                                }
                             },
                             legend : {
                                enabled : false
                             },
                             tooltip : {
                                enabled: false
                             },
                             plotOptions : {
                                series : {
                                    stacking : 'normal'
                                },
                                bar : {
                                    shadow : false,
                                    pointPadding : 0
                                }
                             },
                             series : %@
                             });
  });