class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end
  
  def show
    @book_user = Book.find(params[:id])
    @user = User.find(current_user.id)
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    flash[:notice] = "making a book is error."
    @book.save
    flash[:notice] = "making a book is successfully."
    redirect_to book_path(@book.id)
  end
  
  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    flash[:notice] = "updating a book is error."
    @book.update(book_params)
    flash[:notice] = "updating a book is successfully."
    redirect_to book_path(params[:id])
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  
  private

  def book_params
    params.require(:book).permit(:title, :profile_image, :body)
  end
  
end
