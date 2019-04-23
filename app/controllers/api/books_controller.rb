class Api::BooksController < ApplicationController
  def index
    # @books = current_user.books
    @books = Book.all
    render 'index.json.jbuilder'
  end

  def show
    @book = Book.find(params[:id])
    render 'show.json.jbuilder'
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
