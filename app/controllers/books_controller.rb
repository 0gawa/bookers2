class BooksController < ApplicationController
  def new
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
  end
end
