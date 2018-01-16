
window.onerror = function(err) {
    log('window.onerror: ' + err)
}

function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function() {
                                  callback(WebViewJavascriptBridge)
                                  }, false)
    }
}

connectWebViewJavascriptBridge(function(bridge) {
       var uniqueId = 1
       function log(message, data) {
            var log = document.getElementById('log')
            var el = document.createElement('div')
            el.className = 'logLine'
            el.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data)
            if (log.children.length) { log.insertBefore(el, log.children[0]) }
            else { log.appendChild(el) }
        }
        bridge.init(function(message, responseCallback) {
                var data = { 'Javascript Responds':'Wee!' }
                $("#container").width(message)
                responseCallback(data)
         })
                               
         bridge.registerHandler('testJavascriptHandler', function(data, responseCallback) {
                log('ObjC called testJavascriptHandler with', data)
                var responseData = { 'Javascript Says':'Right back atcha!' }
                log('JS responding with', responseData)
                responseCallback(responseData)
         })
         $('#container').highcharts({
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
                                },
                            }
        });
        var button = document.getElementById('buttons').appendChild(document.createElement('button'))
        button.innerHTML = 'Send message to ObjC'
        button.onclick = function(e) {
               e.preventDefault()
               var data = 'Hello from JS button'
               log('JS sending message', data)
                bridge.send(data, function(responseData) {
                            log('JS got response', responseData)
                })
        }
                               

})