class MessagesController < ApplicationController
  def index
    @groups = Group.all
    # @groups = Group.where(group_id = current_user.id)
  end
end
