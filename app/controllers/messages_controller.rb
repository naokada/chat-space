class MessagesController < ApplicationController

  before_action :find_message_group, only: [:new, :create]

  def index
    @groups = current_user.groups
  end

  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to new_group_message_path(@group)
    else
      flash.now[:alert] = "メッセージを入力してください"
      render :new
    end
  end

private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache, :remove_image).merge(group_id: params[:group_id])
  end

  def find_message_group
    @group = Group.find(params[:group_id])
    @users = @group.users
  end

end
