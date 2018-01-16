Highcharts.theme = {
    colors : ['#7cb5ec', '#434343', '#acf29e', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
    chart : {
        backgroundColor : '#f7f7f7',
        borderWidth : 0,
        plotBackgroundColor : '#f7f7f7',
        plotShadow : false,
        plotBorderWidth : 1
    },
    title : {
        style : {
            color : '#000',
            font : 'bold 16px "Trebuchet MS", Verdana, sans-serif'
        }
    },
    subtitle : {
        style : {
            color : '#666666',
            font : 'bold 12px "Trebuchet MS", Verdana, sans-serif'
        }
    },
    xAxis : {
        gridLineWidth : 1,
        lineColor : '#000',
        tickColor : '#000',
        labels : {
            style : {
                color : '#000',
                font : '11px Trebuchet MS, Verdana, sans-serif'
            }
        },
        title : {
            style : {
                color : '#333',
                fontWeight : 'bold',
                fontSize : '12px',
                fontFamily : 'Trebuchet MS, Verdana, sans-serif'
                
            }
        }
    },
    yAxis : {
        minorTickInterval : 'auto',
        lineColor : '#000',
        lineWidth : 1,
        tickWidth : 1,
        tickColor : '#000',
        labels : {
            style : {
                color : '#000',
                font : '11px Trebuchet MS, Verdana, sans-serif'
            }
        },
        title : {
            style : {
                color : '#333',
                fontWeight : 'bold',
                fontSize : '12px',
                fontFamily : 'Trebuchet MS, Verdana, sans-serif'
            }
        }
    },
    legend : {
        itemStyle : {
            font : '9pt Trebuchet MS, Verdana, sans-serif',
            color : 'black'
            
        },
        itemHoverStyle : {
            color : '#039'
        },
        itemHiddenStyle : {
            color : 'gray'
        }
    },
    labels : {
        style : {
            color : '#99b'
        }
    }
};
// Apply the theme
Highcharts.setOptions(Highcharts.theme);