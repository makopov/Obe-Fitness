class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :current_user
  skip_before_action :verify_authenticity_token

  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.tasks 
  
    # Search by keywords in title or description
    if params[:search].present?
      # Use ILIKE for case-insensitive search in PostgreSQL
      # I'm using SQL Lite here so I can't use ILIKE
      @tasks = @tasks.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    
    # Filter by status
    if params[:completed].present?
      @tasks = @tasks.where(completed: params[:completed])
    end
  
    # Filter by due date
    if params[:due_date].present?
      @tasks = @tasks.where(due_date: params[:due_date])
    end
  
    # Filter by priority
    if params[:priority].present?
      @tasks = @tasks.where(priority: params[:priority])
    end
  
    # Pagination
    @tasks = @tasks.page(params[:page]).per(params[:per_page] || 10)

    render json: @tasks
  end
  

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # GET /tasks/1/history
  def history
    @task = Task.find(params[:id])
    @versions = @task.versions
  end
  
  # GET /tasks/1/version/1
  def version
    @task = Task.find(params[:id])
    @version = @task.versions[params[:version].to_i - 1].reify
  end
  
  # POST /tasks or /tasks.json
  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :due_date, :priority)
  end

  def current_user
    return @current_user if @current_user.present?

    if params[:user_id].present?
      @current_user = User.find(params[:user_id])
    else
      raise "User ID is required"
    end
  end

end
