google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawStuff);

function drawStuff() {
    var data = new google.visualization.arrayToDataTable([
        ['Setup', 'HTML', 'Hello world', 'Symfony', 'Laravel', 'Magento 1'],
        ['Apache', 20269, 14000, 0, 0, 0],
        ['Nginx FPM TCP/IP', 18512, 3686, 0, 0, 0],
        ['Nginx FPM Unix Domain Socket', 18512, 5028, 1490, 0, 0],
        ['Nginx Swoole TCP/IP', 18512, 6365, 0, 0, 0],
        ['Nginx Swoole Unix Domain Socket', 18512, 11172, 4753, 0, 0],
        ['OpenLiteSpeed', 36377, 16494, 0, 0, 0],
        ['OpenLiteSpeed Swoole', 36377, 23544, 0, 0, 0],
        ['Swoole', 0, 39669, 0, 0, 0],
        ['Node.js Express', 0, 6271, 0, 0, 0]
    ]);

    var options = {
        width: 800,
        chart: {
            title: 'Performance Benchmarks',
            subtitle: 'Webservers and applications performance benchmarks'
        },
        bars: 'horizontal', // Required for Material Bar Charts.
        series: {
            0: { axis: 'first' }, // Bind series 0 to an axis.
            1: { axis: 'second' } // Bind series 1 to an axis.
        },
        axes: {
            x: {
                first: {label: 'requests per second'}, // Bottom x-axis.
                second: {side: 'top', label: 'requests per second'} // Top x-axis.
            }
        }
    };

    var chart = new google.charts.Bar(document.getElementById('dual_x_div'));
    chart.draw(data, options);
};
