var dataResponse;

$(document).ready(function() {
  $(".show_button").on("click", function(e) {
    e.preventDefault();
    $(".campaigns_table").toggleClass("display_table");
    if ($(".campaigns_table").hasClass("display_table")) {
      $(this).text("Hide Campaigns");
    } else {
      $(this).text("Show Campaigns");
    }
  });

  var group_campaign_id = $("input.group_campaign_id").val();

  $.ajax('/group_campaigns/' + group_campaign_id + '.json', {
    type: 'GET',
    success: function(data) {
      dataResponse = data;
      console.log(dataResponse);
      var keys = [];
      for (var k in dataResponse) {
        keys.push(k);
      }
      $(".tableJs").handsontable({
        data: dataResponse,
        rowHeaders: dataResponse.title,
        colHeaders: keys,
        fixedRowsTop: 1,
        contextMenu: true
      });
    },
    error: function(data) {
      console.log("Error with the fetch");
    }
  });



});