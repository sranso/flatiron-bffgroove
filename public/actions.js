$(document).ready(function() {
  $(".show_button").on("click", function(e) {
    e.preventDefault();
    $(".campaigns_table").toggleClass("display_table");
    if ($(".campaigns_table").hasClass("display_table")) {
      $(this).html('<input type="submit" value="Hide Campaigns"/>');
    } else {
      $(this).html('<input type="submit" value="Show Campaigns"/>');
    }
  });
});