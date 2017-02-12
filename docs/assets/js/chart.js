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
        hAxis: {
            title: 'Requests per second',
            minValue: 0,
        },
        vAxis: {
            title: 'Stack'
        }
    };

    var chart = new google.charts.Bar(document.getElementById('dual_x_div'));
    chart.draw(data, options);
};
