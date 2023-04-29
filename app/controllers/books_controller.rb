class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
  end
  
  def show
    @book_user = Book.find(params[:id])
    @user = User.find(current_user.id)
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  private

  def book_params
    params.require(:book).permit(:title, :profile_image, :body)
  end
  
end
