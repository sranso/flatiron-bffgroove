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

  function replaceAll(find, replace, str) {
    return str.replace(new RegExp(find, 'g'), replace);
  }

  function makeTable (tableData, keys){
    $(".tableJs").handsontable({
        data: tableData,
        rowHeaders: tableData.title,
        colHeaders: keys,
        fixedRowsTop: 1,
        contextMenu: true,
        readOnly: true
      });
  }
  $.ajax('/group_campaigns/' + group_campaign_id + '.json', {
    type: 'GET',
    success: function(data) {
      var dataResponse = data;
      var campaigns;
      var keys = [];
      campaigns = dataResponse.campaigns;
      delete dataResponse.campaigns;

      for (var k in dataResponse) {
        kNew = replaceAll("_", " ", k).toUpperCase();
        keys.push(kNew);
      }
      makeTable(dataResponse, keys);
    },
    error: function(data) {
      console.log("Error with the fetch");
    }
  });

});