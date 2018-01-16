
         var chart = $('#container').highcharts({
                chart: {
                        type: '%@'
                },
                title: {
                        text: '%@'
                },
                xAxis: {
                        categories:%@,
                        title: {
                                text: '%@'
                                }
                        },
                yAxis: {
                        min: 0,
                        title: {
                                text: '%@'
                                }
                        },
                series: %@,
                plotOptions: {
                        column: {
                                point: {
                                        events: {
                                                click: function (e) {
                                                        var id = this.category;
                                                        bridge.send(id, function(responseData) {
                                                                
                                                                })
                                                        }
                                                }
                                        }
                                }
                        }
        });
