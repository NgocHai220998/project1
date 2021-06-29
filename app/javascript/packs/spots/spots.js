document.addEventListener("turbolinks:load",function() {
   x = document.getElementsByClassName("review-modal");

  for(var i = 0; i<x.length; i++) {
    x[i].onclick = function () {
      const recentReview = document.getElementById(`spot-${this.dataset.id}`)
      recentReview.classList.toggle("hidden")
    };
  }
});
