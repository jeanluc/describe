class NoticesController < ApplicationController
  
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  
  def index
    @notices = Notice.all
  end
    
  def show
    @notice = Notice.find(params[:id])
  end
  
  def new
    @title = "New notice"
    @notice = Notice.new(:biblio => Biblio.new, :resources => [Resource.new])
  end
  
  def create
    @user = current_user
    @notice = Notice.new(params[:notice])
    @notice.user = @user
    if @notice.save
      flash[:success] = "New Notice created."
      redirect_to @notice
    else
      @title = "New notice"
      render 'notices/new'
    end
  end
  
  def edit
    @title = "Edit notice"
    @notice = Notice.find(params[:id])
  end
  
  def update
    @notice = Notice.find(params[:id])
    if @notice.update_attributes(params[:notice])
      flash[:success] = "Notice successfully updated."
      redirect_to @notice
    else
       @title = "Edit notice"
      render 'notices/edit', :id => @notice.id
    end
  end
end
