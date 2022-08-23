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
