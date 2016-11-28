class AnswersController < ApplicationController	
before_action :set_answer, only: [:show, :edit, :update, :destroy]
	def index
	end

	def show
	end

	def new
	end

	def create
    @answer = Answer.new(answer_params)

    @answer.user = current_user

    @answer.question = Question.find(params[:question_id])

    respond_to do |format|
      if @answer.save
        format.html { redirect_to question_path(params[:question_id]), notice: 'Answer was added successfully created.' }
        format.json { render :show, status: :created, location:  question_path(params[:question_id])}
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

	def destroy
	end
private
	# Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
      params.require(:answer).permit(:content, :question_id, :user_id)
    end
end
