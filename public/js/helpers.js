// Button loading state
$(".btn").on("click", function() {
  console.log("asdfsdfasfas");
  loadingMsg = $(this).attr("data-loading");
  $(this).addClass('disabled');
  $(this).html("<i class='fas fa-spinner fa-spin'></i> " + loadingMsg);
});
