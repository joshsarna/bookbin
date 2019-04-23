class Api::ReviewsController < ApplicationController
  def create
    if current_user
      book = Book.find_by(title: params[:book])
      if !book
        book = Book.create(title: params[:book])
      end
      @review = Review.new(
        book_id: book.id,
        worth_reading: params[:worth_reading],
        user_id: current_user.id
      )

      @review.save
      render json: @review.book
    else
      render json: nil
    end
  end
end
