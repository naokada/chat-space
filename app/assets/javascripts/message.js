$(document).on('turbolinks:load', function(){
  setInterval(update, 5000);

  function update(){
    $.ajax({
      url: location.href.json,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(json) {
      var id = $('.main__message__up:last').data('id');
      var insertHTML = '';
      json.messages.forEach(function(message) {
         if (message.id > id ) {
          insertHTML += buildHTML(message);
         }
        });
      $('.main__messages').append(insertHTML);
      var bottomHeight = $('.main__messages')[0].scrollHeight;
      $('.main').animate({ scrollTop: bottomHeight }, 'slow');
    })
  }

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
      var bottomHeight = $('.main__messages')[0].scrollHeight;
      $('.main').animate({ scrollTop: bottomHeight }, 'slow');
    })
    .fail(function() {
      $('.flash').html("メッセージを入力してください").addClass('flash__alert');
    })
  })
});
