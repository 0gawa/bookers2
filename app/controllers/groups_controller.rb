class GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: [:edit, :update]

    def index
        @book = Book.new
        @groups = Group.all
        @user = User.find(current_user.id)
    end

    def show
        @book = Book.new
        @group = Group.find(params[:id])
        @user = User.find(params[:id])
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        @group.owner_id = current_user.id
        if @group.save
            redirect_to groups_path
        else
            render 'new'
        end
    end

    def edit
        @group = Group.find(params[:id])
    end

    def update
        @group = Group.find(params[:id])
        if @group.update(group_params)
            redirect_to groups_path
        else
            render "edit"
        end
    end

    def new_send_mail
        @group = Group.find(params[:group_id])
    end

    def send_notice_mail
        group = Group.find(params[:group_id])
        user = User.find(group.owner_id)
        content = params[:content]
        UserMailer.send_notice_mail(user, content, params[:title]).deliver
        redirect_to confirm_mail_path(group_id: group.id,title: params[:title], content: params[:content])
    end

    def confirm_mail
        @title = params[:title]
        @content = params[:content]
    end

    private
  
    def group_params
      params.require(:group).permit(:name, :introduction, :group_image)
    end
  
    def ensure_correct_user
      group = Group.find(params[:id])
      unless group.owner_id == current_user.id
        redirect_to groups_path
      end
    end
end
