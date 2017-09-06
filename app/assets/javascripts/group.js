$(document).on('turbolinks:load',function() {

  function buildHtmlUser(user) {
    var html = `<div class="chat-group-user clearfix">
  <p class="chat-group-user__name">${ user.name }</p>
  <a class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-name="${ user.name }">追加</a>
</div>`
    return html;
  }

  function buildHtmlAddedUser(user) {
    var html = `<div class='chat-group-user clearfix js-chat-member' id='chat-group-user-8'>
  <input name='group[user_ids][]' type='hidden' value='${ user.data('user-id') }'>
  <p class='chat-group-user__name'>${ user.data('user-name') }</p>
  <a class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</a>
</div>`
    return html;
  }


  $("#user-search-field").on("keyup", function(e) {
    e.preventDefault();
    var input = $.trim($(this).val());
    var href = location.href

    $.ajax({
      type: 'GET',
      url: "/groups/ajax_user_list",
      data: ("keyword=" + input),
      processData: false,
      contentType: false,
      dataType: 'json'
    })

    .done(function(data) {
      var search_list = $("#user-search-result")
      search_list.empty();

      if (input.length !== 0) {
        var users = $(data);
        var users = Object.values(users);
        users.pop();
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

  $("#user-search-result").on("click", "a.user-search-add", function() {
    var added_list = $("#user-added")
    var user = $(this);
    var html = buildHtmlAddedUser(user);
    added_list.append(html);
  });

  $("#user-added").on("click", "a.user-search-remove", function() {
    var user = $(this).parent().parent();
    user.html("");
  });
});
