json.body @message.body
json.image @message.image.thumb.url
json.user_name @message.user.name
json.time @message.created_at.strftime('%Y/%m/%d %H:%M')
