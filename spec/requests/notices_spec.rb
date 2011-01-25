require 'spec_helper'

describe "Notices" do
  
  describe "creation" do
    
    before(:each) do
      @user = Factory(:user)
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end
    
    it "should not make a new notice" do
      lambda do
        visit "notices/new"
        fill_in "notice[biblio_attributes][title]",       :with => ""
        fill_in "notice[biblio_attributes][description]", :with => "General description"
        fill_in "notice[resources_attributes][0][title]", :with => "Resource title"
        fill_in "notice[resources_attributes][0][url]",   :with => ""
        click_button
        response.should render_template('notices/new')
        response.should have_selector("div#error_explanation")
      end.should_not change(Notice,:count)
    end
    
    it "should create a new notice" do
      lambda do
        visit "notices/new"
        fill_in "notice[biblio_attributes][title]",       :with => "Title"
        fill_in "notice[biblio_attributes][description]", :with => "General description"
        fill_in "notice[resources_attributes][0][title]", :with => "Resource title"
        fill_in "notice[resources_attributes][0][url]",   :with => "http://www.example.com"
        click_button
        response.should render_template('notices/show')
        response.should have_selector("div.flash.success", :content => "New Notice created.")
      end.should change(Notice, :count).by(1)
    end
  end  
end
