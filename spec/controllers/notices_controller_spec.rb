require 'spec_helper'

describe NoticesController do
  
  render_views
    
  describe "GET 'new'" do
    
    describe "for non-signed-in users" do
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end
    
    describe "for signed-in users" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should be successful" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "New notice")
      end
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @biblio_attributes = { :title => "", :description => "" }
        @attr = { :biblio_attributes => @biblio_attributes }
      end

      it "should not create a notice" do
        lambda do
          post :create, :notice => @attr
        end.should_not change(Notice, :count)
      end
      
      it "should have the right title" do
        post :create, :notice => @attr
        response.should have_selector("title", :content => "New notice")
      end
      
      it "should render the 'new' page" do
        post :create, :notice => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do

      before(:each) do
        @biblio_attributes = { :title => "Title", :description => "Description" }
        @attr = { :biblio_attributes => @biblio_attributes }
      end

      it "should create a new notice" do
        lambda do
          post :create, :notice => @attr
        end.should change(Notice, :count).by(1)
      end
      
      it "should redirect to the notice show page" do
        post :create, :notice => @attr
        response.should redirect_to(notice_path(assigns(:notice)))
      end
      
      it "should have a success message" do
         post :create, :notice => @attr
         flash[:success].should =~ /New Notice created./i
       end
    end
  end
  
  describe "POST 'edit'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
      @biblio = Biblio.new(:title => "Title", :description => "Description")
      @notice = Notice.create!(:user => @user, :biblio => @biblio)
    end

    describe "failure" do

      before(:each) do
        @biblio_attributes = { :title => "", :description => "" }
        @attr = { :biblio_attributes => @biblio_attributes }
      end

      it "should not create a new notice" do
        lambda do
          post :update, :notice => @attr, :id => @notice.id
        end.should_not change(Notice, :count)
      end
      
      it "should have the right title" do
        post :update, :notice => @attr, :id => @notice.id
        response.should have_selector("title", :content => "Edit notice")
      end
      
      it "should render the 'edit' page" do
        post :update, :notice => @attr, :id => @notice.id
        response.should render_template('edit')
      end
    end
    
    describe "success" do

      before(:each) do
        @biblio = Biblio.new(:title => "Title", :description => "Description")
        @notice = Notice.create!(:user => @user, :biblio => @biblio)
        @biblio_attributes = { :title => "New Title", :description => "New Description" }
        @new_attr = { :biblio_attributes => @biblio_attributes }
      end

      it "should redirect to the notice show page" do
        post :update, :notice => @attr, :id => @notice.id
        response.should redirect_to(notice_path(assigns(:notice)))
      end
      
      it "should have a success message" do
         post :update, :notice => @attr, :id => @notice.id
         flash[:success].should =~ /Notice successfully updated./i
      end
      
      it "should have changed the title attribute" do
        post :update, :notice => @new_attr, :id => @notice.id
        changed_notice = Notice.find(@notice.id)
        changed_notice.biblio.title.should == @biblio_attributes[:title]
      end
      
      it "should have changed the description attribute" do
        post :update, :notice => @new_attr, :id => @notice.id
        changed_notice = Notice.find(@notice.id)
        changed_notice.biblio.description.should == @biblio_attributes[:description]
      end
    end
  end
end
