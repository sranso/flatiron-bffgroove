var data1;
$(document).ready(function() {

  function strip_tags(input, allowed){
    allowed = (((allowed || "") + ""). toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');
    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi, commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
    return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
      return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
    });
  }

  var titleRenderer = function (instance, td, row, col, prop, value, cellProperties) {
    var escaped = Handsontable.helper.stringify(value);
    escaped = strip_tags(escaped, '<a>'); //be sure you only allow certain HTML tags to avoid XSS threats (you should also remove unwanted HTML attributes)
    td.innerHTML = escaped;
    return td;
  };

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

  $.ajax('/group_campaigns.json', {
    type: 'GET', 
    success: function(data){
      data1 = data; 
      var dataResponse = data; 
      var keysGroupCampaigns = []; 

      for (var k in dataResponse[0]){
        kNew = replaceAll("_", " ", k).toUpperCase(); 
        keysGroupCampaigns.push(kNew);
      }
      makeGroupCampaignsTable(".tableGroupCampaigns", dataResponse, keysGroupCampaigns);
      makeSortable(".tableGroupCampaigns");
    }, 

    error: function(data){
      console.log("Error with the fetch")
    }
  })

  function makeGroupCampaignsTable(div, tableData, keys){
    $(div).handsontable({
          data: tableData,
          colHeaders: keys,
          readOnly: true,
          columnSorting: true,
          persistentState: true,
          manualColumnMove: true,
          manualColumnResize: true,
          contextMenu: true,
          columns: [
            {data: "title", renderer: titleRenderer}, 
            {data: "send_date"} 
          ]
        });
  }

});


