class MessagesController < ApplicationController

  before_action :set_groups, :users_groups, only: [:new, :create]

  def index
  end

  def new
    @message = Message.new
    @messages = @group.messages
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      flash.now[:alert] = "メッセージを入力してください"
      render :new
    end
  end

private
  def message_params
    params.require(:message).permit(:body, :image, :image_cache, :remove_image).merge(group_id: params[:group_id])
  end

  def set_groups
    @group = Group.find(params[:group_id])
    @users = @group.users
  end

  def users_groups
    @groups = current_user.groups
  end

end
