class Api::ReviewsController < ApplicationController
  def index
    if current_user
      @reviews = current_user.reviews
      render 'index.json.jbuilder'
    else
      render json: nil
    end
  end

  def create
    if current_user
      book = Book.find_by(title: params[:book].split(" (by: ")[0])
      if !book
        book = Book.create(title: params[:book].split(" (by: ")[0])
      end
      @review = Review.new(
        book_id: book.id,
        worth_reading: params[:worth_reading],
        user_id: current_user.id
      )

      if !Review.find_by({book_id: book.id, user_id: current_user.id})
        @review.save
      end
      render 'show.json.jbuilder'
    else
      render json: nil
    end
  end
end
