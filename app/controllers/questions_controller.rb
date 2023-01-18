class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show destroy edit update]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params

    if @question.save
      redirect_to questions_path
      flash[:success] = 'Post successfully created'
    else
      render :new
      flash[:notice] = 'Not created'
    end
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to questions_path
      flash[:success] = 'Post successfully updated'
    else
      render :edit
      flash[:notice] = 'Not created'
    end
  end

  def destroy
    @question.destroy
    flash[:success] = 'Post deleted'

    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find params[:id]
  end
end
