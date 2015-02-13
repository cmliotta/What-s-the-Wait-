$(document).ready(function(){
  GetQuestions();
});

function GetQuestions() {
  $.ajax({
      url: 'http://localhost:3000',
      type: 'GET',
      dataType: 'JSON',
    }).success(function(response){
      console.log('party time');
      $("#questions_container").html(html);
    }).fail(function(response){
      console.log('you suck');
    });
}

}
