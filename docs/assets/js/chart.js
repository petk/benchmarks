google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawStuff);

function drawStuff() {
    var jsonData = $.ajax({
            url: "assets/js/results.json",
            dataType: "json",
            async: false
    }).responseText;

    var data = new google.visualization.DataTable(jsonData);

    var options = {
        width: 950,
        backgroundColor: 'transparent',
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
