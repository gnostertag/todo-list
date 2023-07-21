class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show edit update destroy ]

 
  def index
    @todos = Todo.all
  end

 
  def show
    @task = Task.new
    @tasks = @todo.tasks
  end

  
  def new
    @todo = Todo.new
  end


  def edit
  end

 
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todo_url(@todo), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to todo_url(@todo), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy_task
    @task = Task.find(params[:task_id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to todo_url(@task.todo), notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  def destroy
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:name)
    end
end
