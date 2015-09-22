class GoalsController < ApplicationController
  before_action :require_log_in

  def index
    @goals = Goal.all.where(user_id: current_user.id)
    render :index
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    if @goal.destroy
      redirect_to goals_url
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to goals_url
    end
  end

  def require_log_in
    redirect_to new_session_url unless logged_in?
  end

  def goal_params
    params.require(:goal).permit(:description, :complete)
  end
end
