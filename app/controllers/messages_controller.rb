class MessagesController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def new
    @groups = current_user.groups
    @group = find_message_group
    @users = @group.users
    @message = Message.new
  end

  def create
    binding.pry
    @group = find_message_group
    @message = Message.create(body: message_params[:body], image: message_params[:image], user_id: current_user.id, group_id: @group.id)
    redirect_to new_group_message_path(@group)
  end

private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache, :remove_image)
  end

  def find_message_group
    @group = Group.find(params[:group_id])
  end

end
