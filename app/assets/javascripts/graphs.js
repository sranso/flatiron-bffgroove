var yAxisInput;
var response;

$(document).ready(function() {
  $(".dropdown a").click(function(e){
    e.preventDefault();
    yAxisInput = $(this).text();
  });
});

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

d3.json("/group_campaigns.json", function(error, data) {
  response = data;
  // var columnNames = d3.keys(data[0]).filter(function(key) { return key == yAxisInput });
  // data.forEach(function(d) {
  // });
  x0.domain(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]);
  y.domain([0, d3.max(data, function(d){ return d3.max(d.revenue_created, function(d) {return d.value; }); })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Population");

  var weekday = svg.selectAll(".weekday")
        .data(data)
      .enter().append("g")
        .attr("class", "g")
        .attr("transform", function(d){ return "translate(" + x0(d.total_recipients) + ",0)"; });

});