class AnswersController < ApplicationController
  before_action :set_question!
  before_action :set_answer!, except: :create # order of before actions important!!!

  def update
    if @answer.update answer_params
      flash[:success] = 'Answer successfully updated'
      redirect_to question_path(@question, anchor: "answer-#{@answer.id}")
    else
      render :edit
      flash[:notice] = 'Not created'
    end
  end

  def edit
  end

  def create
    @answer = @question.answers.build answer_params  # create nested entity

    if @answer.save
      flash[:success] = "Answer created!"
      redirect_to question_path(@question) # in single No questionSSSS
    else
      @answers = @question.answers.order created_at: :desc
      render 'questions/show' # rendering question NOT ANSWER!!!
    end
  end

  def destroy
    answer = @question.answers.find params[:id]
    answer.destroy
    flash[:success] = 'Answer deleted'
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question! # danger method could return the error
    @question = Question.find params[:question_id] # check if question exist
  end

  def set_answer!
    @answer = @question.answers.find params[:id]
  end
end
