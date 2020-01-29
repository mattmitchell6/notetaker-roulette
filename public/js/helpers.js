// Button loading state
$(".btn").on("click", function() {
  loadingMsg = $(this).attr("data-loading");
  $(this).addClass('disabled');
  $(this).html("<i class='fas fa-spinner fa-spin'></i> " + loadingMsg);
});


// reload function
$(".btn.reload").on("click", function() {
  console.log('reloading...');
  loadingMsg = $(this).attr("data-loading");
  $(this).addClass('disabled');
  $(this).html("<i class='fas fa-spinner fa-spin'></i> " + loadingMsg);
  window.location.reload();
});
