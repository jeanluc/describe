require 'spec_helper'

describe Resource do
  
  before(:each) do
    @attr = {
      :technicalRequirements => "Technical requirements",
      :url => "http://www.example.com",
      :title => "Resource Title",
      :format => "text/html"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Resource.create!(@attr)
  end
  
  it "should require a url" do
    no_url_resource = Resource.new(@attr.merge(:url => ""))
    no_url_resource.should_not be_valid
  end
  
  describe "notice association" do
    
    before(:each) do
      @user = Factory(:user)
      @biblio = Biblio.new(:title => "Title", :description => "Description")
      @resource = Resource.new(:url => "http://www.example.com")
      @notice = Notice.new(
        :biblio => @biblio,
        :resources => [@resource]
        )
    end
    
    it "should have a notice attribute" do
      @resource.should respond_to(:notice)
    end
        
    it "should have the right associated notice" do
      @resource.notice_id.should == @notice.id
      @notice.resources[0].should == @resource
    end
  end
  
end
