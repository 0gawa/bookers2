class UsersController < ApplicationController
  def new
   @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    @is_room = false
    @books = @user.books
    @book = Book.new
    @today_books = @user.books.created_today
    @yesterday_books = @user.books.created_yesterday
    @this_week_books = @user.books.created_this_week
    @last_week_books = @user.books.created_last_week
    
    if @user.id == current_user.id || @current_entry.nil? || @another_entry.nil?
      @room = Room.new
      @entry = Entry.new
      return 0  #終了
    end
    @current_entry.each do |current|
      @another_entry.each do |another|
        if current.room_id == another.room_id
          @is_room = true
          @room_id = current.room_id
          break
        end
      end
    end
    unless @is_room
      @room = Room.new
      @entry = Entry.new
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
    else
      redirect_to user_path(current_user.id)
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "making a book is successfully."
      redirect_to book_path(@book.id)
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    unless @user.id == current_user.id
        redirect_to user_path(current_user.id)
    end
    if @user.update(user_params)
      flash[:notice] = "updating user's information is successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
