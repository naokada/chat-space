class GroupsController < ApplicationController
  def show
  end

  def new
    @group = Group.new
  end

  def create
    redirect_to controller: :messages, action: :index
  end

  def edit
  end

  def update
  end

end
