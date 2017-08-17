class GroupsController < ApplicationController

  before_action :find_group, only: [:edit, :update]

  before_action :users_groups, only: [:index]

  def index
  end

  def show
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(create_params)
    if @group.save
      redirect_to root_path, notice: "グループを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(create_params)
      redirect_to root_path, notice: "グループを編集しました"
    else
      render :new
    end
  end

  private
  def create_params
    params.require(:group).permit(:name, {user_ids:[]})
  end

  def find_group
    @group = Group.find(params[:id])
  end

  def users_groups
    @groups = current_user.groups
  end
end
