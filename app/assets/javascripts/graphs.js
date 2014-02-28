var margin = {top: 20, right: 20, bottom: 30, left: 40},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom,
    x0 = d3.scale.ordinal()
         .rangeRoundBands([0, width], .1),
    x1 = d3.scale.ordinal(),
    y = d3.scale.linear()
        .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]),
    xAxis = d3.svg.axis()
        .scale(x0)
        .orient("bottom"),
    yAxis = d3.svg.axis()
        .scale(y)
        .orient("left")
        .tickFormat(d3.format(".2s"));

var svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

d3.json("/campaigns.json", function(error, data) {
  var keys = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  var columnNames = d3.keys(data[0]).filter(function(key) { return key == "total_clicks" });
  data.forEach(function(d) {

  });
});