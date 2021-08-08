require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("./spots/spots")

document.addEventListener("turbolinks:load",function() {
  flash = document.getElementById('flash');
  setTimeout(function(){
    if (flash!= null)
      flash.remove();
  }, 5000);
});
