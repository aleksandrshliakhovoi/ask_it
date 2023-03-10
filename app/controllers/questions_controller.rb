class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[show destroy edit update]

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)

    @questions = @questions.decorate

    # @questions = Question.order(created_at: :desc).page params[:page] for kaminari
  end

  def show
    @question = @question.decorate
    @answer = @question.answers.build # here is answer object init
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @answers = @answers.decorate # need in two steps because decorator not great work with drapper

    #@answers = @question.answers.order(created_at: :desc).page(params[:page]).per(3)
    #Answer.where(question: @question).limit(2).order(created_at: :desc)
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

  def about
    render json: formate_questions
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find params[:id]
  end

  def formate_questions
    Question.includes(:answers).limit(5).each { |q| q.answers.each{ |a| a.body } }
  end
end

