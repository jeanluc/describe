require 'spec_helper'

describe Biblio do
  
  before(:each) do
    @attr = {
      :title => "Main Title",
      :description => "General description of the resource"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Biblio.create!(@attr)
  end
  
  it "should require a title" do
    no_title_biblio = Biblio.new(@attr.merge(:title => ""))
    no_title_biblio.should_not be_valid
  end
  
  describe "notice association" do
    before(:each) do
      @biblio = Biblio.create(@attr)
      @user = Factory(:user)
      @n1 = Factory(:notice, :biblio => @biblio, :user => @user, :created_at => 1.day.ago)
    end
    
    it "should have a notice attribute" do
      @biblio.should respond_to(:notice)
    end
    
    it "should have the right notice" do
      @biblio.notice.should == @n1
    end
  end
end
