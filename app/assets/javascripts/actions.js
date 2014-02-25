var data1;
$(document).ready(function() {
  $(".show_button").on("click", function(e) {
    $(".tableGCCampaigns").toggleClass("hide_table");
    if ($(".tableGCCampaigns").hasClass("hide_table")) {
      $(this).text("Show Campaigns");
    } else {
      $(this).text("Hide Campaigns");
    }
  });

  var group_campaign_id = $("input.group_campaign_id").val();

  function replaceAll(find, replace, str) {
    return str.replace(new RegExp(find, 'g'), replace);
  }

  function makeGroupedTable (div, tableData, keys){
    $(div).handsontable({
        data: tableData,
        colHeaders: keys,
        readOnly: true,
        columnSorting: true,
        persistentState: true,
        manualColumnMove: true,
        manualColumnResize: true,
        contextMenu: true
      });
  }

  function makeCampaignsTable (div, tableData, keys){
    $(div).handsontable({
        data: tableData,
        colHeaders: keys,
        readOnly: true,
        columnSorting: true,
        persistentState: true,
        manualColumnMove: true,
        contextMenu: true
      });
  }

  function makeDateCampaignsTable (div, tableData, keys){
    $(div).handsontable({
        data: tableData,
        colHeaders: keys,
        readOnly: true,
        columnSorting: true,
        persistentState: true,
        manualColumnMove: true,
        contextMenu: true
      });
  }

  function makeSortable(tableObject) {
    var table = $(tableObject).handsontable('getInstance');
    $('.reset-state').on('click', function() {
      table.updateSettings({
        columnSorting: true,
        manualColumnMove: true,
        manualColumnResize: true,
        contextMenu: true
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
      var dataResponse = data[0];
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

  $.ajax('/campaigns.json', {
    type: 'GET',
    success: function(data) {
      data1 = data;
      var dataResponse = data;
      var keysCampaigns = [];

      for (var k in dataResponse[0]) {
        kNew = replaceAll("_", " ", k).toUpperCase();
        keysCampaigns.push(kNew);
      }

      makeCampaignsTable(".tableCampaigns", dataResponse, keysCampaigns);
      makeSortable(".tableCampaigns");
    },
    error: function(data) {
      console.log("Error with the fetch");
    }
  });

  // $.ajax('/campaigns/date'  + campaign_from + campaign_to + '.json', {
  //   type: 'GET',
  //   success: function(data) {
  //     data1 = data;
  //     var dataResponse = data;
  //     var keysDateCampaigns = [];

  //     for (var k in dataResponse[0]) {
  //       kNew = replaceAll("_", " ", k).toUpperCase();
  //       keysDateCampaigns.push(kNew);
  //     }

  //     makeDateCampaignsTable(".tableDateCampaigns", dataResponse, keysDateCampaigns);
  //     makeSortable(".tableDateCampaigns");
  //   },
  //   error: function(data) {
  //     console.log("Error with the fetch");
  //   }
  // });

  
  $( "#from" ).datepicker({
    defaultDate: "+1w",
    changeMonth: true,
    numberOfMonths: 1,
    onClose: function( selectedDate ) {
      $( "#to" ).datepicker( "option", "minDate", selectedDate );
    }
  });
  $( "#to" ).datepicker({
    defaultDate: "+1w",
    changeMonth: true,
    numberOfMonths: 1,
    onClose: function( selectedDate ) {
      $( "#from" ).datepicker( "option", "maxDate", selectedDate );
    }
  });

});