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

  
});