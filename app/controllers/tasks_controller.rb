class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done, :wip]

  # GET /tasks
  # GET /tasks.json
  def index
    #@tasks = Task.all.includes(:user)
    @tasks = Task.where(user_id: current_user.id).includes(:user) if user_signed_in?
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks/1/done
  def done
    @task.update(status: "完了")
    @tasks = Task.all.includes(:user)
    #render :index

    #@task = Task.find(params[:taskid])
    #respond_to do |format|
    #  if @task.update(status: "done")
    #    @tasks = Task.all.includes(:user)
    #    format.html { render :index }
    #    format.json { render :index }
    #  else
    #    @tasks = Task.all.includes(:user)
    #    format.html { render :index }
    #    format.json { render json: @task.errors, status: :unprocessable_entity }
    #  end
    #end

  end

    # POST /tasks/1/wip
    def wip
      @task.update(status: "途中")
      @tasks = Task.all.includes(:user)
    end

  # POST /tasks
  # POST /tasks.json
  def create
    # binding.pry
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        #format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.html { redirect_to action: 'index' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:content, :title, :start_date, :end_date, :status).merge(user_id: current_user.id)
    end
end
