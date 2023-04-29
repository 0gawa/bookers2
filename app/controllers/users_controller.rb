class UsersController < ApplicationController
  def new
   @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    flash[:notice] = "making a book is error."
    @book.save
    flash[:notice] = "making a book is successfully."
    redirect_to book_path(@book.id)
  end
  
  def index
    @user = User.find(current_user.id)
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    flash[:notice] = "updating a book is error."
    @user.update(user_params)
    flash[:notice] = "updating user's information is successfully."
    redirect_to user_path(@user.id)
  end
  
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
