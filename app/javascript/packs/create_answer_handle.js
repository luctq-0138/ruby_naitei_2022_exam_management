window.check_question_type=function(element){
  var type = $('#question_question_type').val();
  if(type == 0 && element.checked){
    $(".answer-check-box").map(function(){
        this.checked = false;
    })
    element.checked = true;
  }
}


window.clearChecked = function(){
  $(".answer-check-box").map(function(){
        this.checked = false;
  })
}

$(document).on("turbolinks:load", function () {
  var remove_button = $(".remove_fields");
  if (remove_button.length >= 2){
    for (let step = 0; step < 2; step++) {
     remove_button[step].remove();
    }
  }
})
