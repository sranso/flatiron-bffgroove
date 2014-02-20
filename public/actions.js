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
  var selectionGroupCampaign;

  $.ajax('/group_campaigns/' + group_campaign_id + '.json', {
    type: 'GET',
    success: function(data) {
      selectionGroupCampaign = data;
    },
    error: function(data) {
      console.log("Error with the fetch");
    }
  });


  
});