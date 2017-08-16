class MessagesController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def new
    @group = find_message_group
    @users = @group.users
    @message = Message.new
  end

  def create
    @group = find_message_group
    @message = Message.new(body: message_params[:body], image: message_params[:image], user_id: current_user.id, group_id: @group.id)
    if @message.save
      redirect_to new_group_message_path(@group)
    else
      redirect_to new_group_message_path(@group), alert: "メッセージを入力してください"
    end
  end

private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache, :remove_image)
  end

  def find_message_group
    @group = Group.find(params[:group_id])
  end

end
