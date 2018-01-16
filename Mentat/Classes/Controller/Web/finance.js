/**
 * Created by dev on 04/12/14.
 */
$('#container').highcharts({
    chart: {
        type: 'area'
    },
    title: {
        text: 'Total Expenditure'
    },
    xAxis: {
        categories: ['(Jan-Mac) 2013', '(Apr-Jun) 2013', '(Jul-Sept) 2013', '(Oct-Dec) 2013',
            '(Jan-Mac) 2014', '(Apr-Jun) 2014', '(Jul-Sept) 2014', '(Oct-Dec) 2014'],
        tickmarkPlacement: 'on',
        title: {
            enabled: false
        }
    },
    yAxis: {
        title: {
            text: ' BND Juta / Million'
        },
        labels: {
            formatter: function () {
                return this.value / 1000;
            }
        }
    },
    plotOptions: {
        area: {
            trackByArea: true,
            stacking: 'normal',
            lineColor: '#666666',
            lineWidth: 1,
            marker: {
                lineWidth: 1,
                lineColor: '#666666'
            },
            events: {
                click: function(event) {
                    if (this.name === 'Ordinary Expenditure') {
                    }
                }
            }
        }
    },
    series: [{
        name: 'Charged Expenditure',
        data: [457.38, 354.66, 401.90, 383.44, 383.68, 371.22, 352.10, 388.21]
    }, {
        name: 'Ordinary Expenditure',
        data: [1482.45, 855.17, 944.89, 1106.17,409.17, 940.22, 990.66, 1206.88]
    }, {
        name: 'Development Expenditure',
        data: [464.31, 339.48, 350.18, 395.1, 337.08, 332.36, 265.65]
    }]
});

