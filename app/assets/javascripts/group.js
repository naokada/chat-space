$(document).on('turbolinks:load',function() {

  function buildHtmlUser(user) {
    var html = `<div class="chat-group-user clearfix">
  <p class="chat-group-user__name">${ user.name }</p>
  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
</div>`
    return html;
  }


  $("#user-search-field").on("keyup", function(e) {
    e.preventDefault();
    var input = $.trim($(this).val());
    var href = location.href

    $.ajax({
      type: 'GET',
      url: href,
      data: { keyword: input },
      processData: false,
      contentType: false,
      dataType: 'json'
    })

    .done(function(data) {
      var search_list = $("#user-search-result")
      search_list.empty();

      if (input.length !== 0) {
        var users = $(data)[0]["users"]
        users.forEach(function(user) {
          var html = buildHtmlUser(user);
          search_list.append(html);
        });
      }
    })
    .fail(function() {
      alert("ユーザー検索に失敗しました");
    })
  });

  $(".user-search-add").on("click", function(e) {
    e.preventDefault();

    $.ajax({
      type: 'POST',
      url: href,
      data: { id: user-id },
      processData: false,
      contentType: false,
      dataType: 'json'
    })

  });
});
