require 'spec_helper'

describe Notice do
  
  before(:each) do
    @user = Factory(:user)
    @biblio = Biblio.new(:title => "Title", :description => "Description")
    @resource = Resource.new()
    @attr = {
      :user => @user,
      :biblio => @biblio,
      :resources => [@resource]
    }
  end
  
  it "should create a new instance given valid attributes" do
    Notice.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  describe "user association" do
    
    before(:each) do
      @notice = @user.notices.create(@attr)
    end
    
    it "should have a user attribute" do
      @notice.should respond_to(:user)
    end
    
    it "should require an owner (user)" do
      no_owner_notice = Notice.new(@attr.merge(:user => nil))
      no_owner_notice.should_not be_valid
    end

    it "should belongs to an existing owner" do
      new_notice = Notice.create!(@attr)
      User.find(new_notice.user_id)
    end
    
    it "should have the right associated user" do
      @notice.user_id.should == @user.id
      @notice.user.should == @user
    end
  end
  
  describe "biblio association" do
    
    before(:each) do
      @notice = Notice.create(@attr)
    end
    
    it "should have a biblio attribute" do
      @notice.should respond_to(:biblio)
    end
    
    it "should require an owner (user)" do
      no_biblio_notice = Notice.new(@attr.merge(:biblio => nil))
      no_biblio_notice.should_not be_valid
    end

    it "should belongs to an existing owner" do
      new_notice = Notice.create!(@attr)
      User.find(new_notice.user_id)
    end
    
    it "should have the right associated user" do
      @notice.biblio.notice_id.should == @notice.id
      @notice.biblio.should == @biblio
    end
    
    it "should destroy associated bibliographic description" do
      @biblio = @notice.biblio
      @notice.destroy
      Biblio.find_by_id(@biblio.id).should be_nil
    end
  end
end
