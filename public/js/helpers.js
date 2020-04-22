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

var appContainer = document.getElementById('app-container');

$('#select-winner').click(function (e) {
    e.preventDefault();                   // prevent default anchor behavior
    var goTo = this.getAttribute("href"); // store anchor href
    console.log("loading...");

    // do something while timeOut ticks ...
    appContainer.innerHTML = '<h1 id="loadtitle" class="text-center topspace-lg">Cooking up a winner...</h1><div id="cooking"><div class="bubble"></div><div class="bubble"></div><div class="bubble"></div><div class="bubble"></div><div class="bubble"></div><div id="area"><div id="sides"><div id="pan"></div><div id="handle"></div></div><div id="pancake"><div id="pastry"></div></div></div></div>'

    setTimeout(function(){
         window.location = goTo;
    }, 3000);                             // time in ms
});
