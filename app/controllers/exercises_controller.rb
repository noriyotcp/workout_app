class ExercisesController < ApplicationController
  def index
  end

  def new
    @exercise = current_user.exercises.build
  end

  def create
    @exercise = current_user.exercises.build(exercise_params)

    if @exercise.save
      flash[:success] = "Exercise has been created"
      redirect_to [current_user, @exercise]
    else
      flash[:alert] = "Exercise has not been created"
      render :new
    end
  end

  private

    def exercise_params
      params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user)
    end
end
