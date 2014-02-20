$(document).ready(function() {
  $(".tableGCCampaigns").addClass("hide_table");
  $(".show_button").on("click", function(e) {
    e.preventDefault();
    $(".tableGCCampaigns").toggleClass("hide_table");
    if ($(".tableGCCampaigns").hasClass("hide_table")) {
      $(this).text("Hide Campaigns");
    } else {
      $(this).text("Show Campaigns");
    }
  });

  var group_campaign_id = $("input.group_campaign_id").val();

  function replaceAll(find, replace, str) {
    return str.replace(new RegExp(find, 'g'), replace);
  }

  function makeGroupedTable (div, tableData, keys){
    $(div).handsontable({
        data: tableData,
        rowHeaders: tableData.title,
        colHeaders: keys,
        fixedRowsTop: 1,
        contextMenu: true,
        readOnly: true,
        columnSorting: true,
        persistentState: true,
        manualColumnMove: true,
        manualColumnResize: true
      });
  }

  function makeCampaignsTable (div, tableData, keys){
    $(div).handsontable({
        data: tableData,
        colHeaders: keys,
        fixedRowsTop: 1,
        contextMenu: true,
        readOnly: true,
        columnSorting: true,
        persistentState: true,
        manualColumnMove: true,
        manualColumnResize: true
      });
  }

  function makeSortable(tableObject) {
    var table = $(tableObject).handsontable('getInstance');
    $('.reset-state').on('click', function() {
      table.updateSettings({
        columnSorting: true,
        manualColumnMove: true,
        manualColumnResize: true
      });

      $('.state-loaded').fadeOut(300);
    });

    // do we need this? doesn't seem to add any additional functionality..
    var storedData = {};
    table.PluginHooks.run('persistentStateLoad', '_persistentStateKeys', storedData);
    var savedKeys = storedData.value;
    if (savedKeys && savedKeys.length > 0) {
      $('.state-loaded').show();
    };
  }

  $.ajax('/group_campaigns/' + group_campaign_id + '.json', {
    type: 'GET',
    success: function(data) {
      var dataResponse = data;
      var campaigns;
      var keysGroupCampaign = [];
      var keysCampaign = [];
      campaigns = dataResponse.campaigns;
      delete dataResponse.campaigns;

      for (var k in dataResponse) {
        kNew = replaceAll("_", " ", k).toUpperCase();
        keysGroupCampaign.push(kNew);
      }
      for (var k in campaigns[0]) {
        kNew = replaceAll("_", " ", k).toUpperCase();
        keysCampaign.push(kNew);
      }
      makeGroupedTable(".tableGroupCampaign", dataResponse, keysGroupCampaign);
      makeCampaignsTable(".tableGCCampaigns", campaigns, keysCampaign);
      makeSortable(".tableGroupCampaign");
      makeSortable(".tableGCCampaigns");
    },
    error: function(data) {
      console.log("Error with the fetch");
    }
  });


});