class Api::BooksController < ApplicationController
  def recommendation
    @book = Book.recommendation(current_user)
    if @book
      render 'show.json.jbuilder'
    else
      render json: {id: 0}
    end
  end

  def index
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

  def update
    @book = Book.find(params[:id])
    @book.title = params[:title] || @book.title
    @book.author = params[:author] || @book.author
    @book.image_url = params[:image_url] || @book.image_url
    @book.save
    render 'show.json.jbuilder'
  end
end
