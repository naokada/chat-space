$(document).on('turbolinks:load', function(){
  function buildHTML(message){
    if (message.image != null){
    var image = `<img src=${ message.image }>`;
    } else {
      image = '';
    }
    if (message.body != null){
    var body = `${ message.body }`;
    } else {
      body = '';
    }
    var html = `<div class="main__message__up"><div class="main__message__up__name">${ message.user_name }</div><div class="main__message__up__date">${ message.time }</div></div><div class="main__message__low">${ body }</div><div class="main__message__low">${ image }</div><br>`
    return html;
  }
  $('#new_message').on('submit', function(e){
    $('.flash').html("").removeClass('flash__alert');
    e.preventDefault();
    var $form = $(this);
    var $button = $(".form__box__send input");
    var formData = new FormData(this);
    var href = "../messages.json";
    $.ajax({
      url: href,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false,
      timeout: 10000,
      beforeSend: function(xhr, settings) {
        $button.attr('disabled', true);
      },
      complete: function(xhr, textStatus) {
        $button.attr('disabled', false);
      },
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.main__messages').append(html);
      $form[0].reset();
      return false;
    })
    .fail(function() {
      $('.flash').html("メッセージを入力してください").addClass('flash__alert');
    })
  })
});
