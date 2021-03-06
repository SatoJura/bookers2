class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @books = Book.all
    @book_new = Book.new
    # @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book_new)
    else
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book.user_id = current_user.id
    @book = Book.find(params[:id])
    @book.save
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render  "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
	   unless 
	    @book.user == current_user
    	redirect_to books_path
	   end
	end
end
