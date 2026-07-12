class TasksController < ApplicationController
  before_action :set_task,   only: %i[show edit update destroy]
  before_action :load_users, only: %i[new create edit update]

  def index
    @filter = params[:filter]
    @tasks = filtered_tasks.includes(:user).order(:due_date)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: "Görev oluşturuldu."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Görev güncellendi."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Görev silindi."
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def load_users
    @users = User.order(:name)
  end

  def filtered_tasks
    case params[:filter]
    when "completed" then Task.completed
    when "pending"   then Task.pending
    when "due_soon"  then Task.due_soon
    else                  Task.all
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :user_id)
  end
end
