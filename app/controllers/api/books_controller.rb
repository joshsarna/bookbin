class Api::BooksController < ApplicationController
  def index
    @books = Book.all
    # @books = current_user.books
    render 'index.json.jbuilder'
  end

  def create
    @book = Book.new(
      title: params[:title],
      author: params[:author],
      image_url: params[:image_url]
    )

    @book.save
    render 'show.json.jbuilder'
  end
end
