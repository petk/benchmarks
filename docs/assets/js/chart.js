google.charts.load('current', {'packages':['corechart', 'bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
    var jsonData = $.ajax({
            url: "assets/js/results.json",
            dataType: "json",
            async: false
    }).responseText;

    var data = new google.visualization.DataTable(jsonData);

    var options = {
        height: 600,
        chart: {
            title: 'Webservers and applications performance benchmarks'
        },
        bars: 'horizontal',
        hAxis: {
            title: 'Requests per second',
            minValue: 0
        },
        vAxis: {
            title: 'Stack'
        },
        series: {
          0: {axis: 'rqs'},
          1: {axis: 'rqs'},
          2: {axis: 'rqs'},
          3: {axis: 'rqs'},
          4: {axis: 'rqs'},
          5: {axis: 'rqs'}
        },
        axes: {
          x: {
            rqs: {label: 'Requests per second'}
          }
        }
    };

    var chart = new google.charts.Bar(document.getElementById('benchmark-chart'));
    chart.draw(data, options);
};
