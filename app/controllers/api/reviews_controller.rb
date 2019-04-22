class Api::ReviewsController < ApplicationController
  def create
    @review = Review.new(
      book_id: params[:book_id],
      worth_reading: params[:worth_reading],
      user_id: current_user.id
    )

    @review.save
    render json: @review
  end
end
