class BooksController < ApplicationController
  def index
    @books = Book.all
    @user = current_user
    
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render "index"
    end

  end

  def edit
    @book = Book.find(params[:id])
    @book.save
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
