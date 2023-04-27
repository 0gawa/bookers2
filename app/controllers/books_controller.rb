class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
