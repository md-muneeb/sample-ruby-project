require "rails_helper"

RSpec.describe "Item", :type => :request do

    it "successfully creates a new item and redirects to index page" do
      get new_item_path
      expect(response).to render_template(:new)
  
      post items_path, :params => { :item => { :name => "Bread", :desc => "Grocery", :cost => -4.25, :fish_id => 1 }}
  
      expect(response).to redirect_to(items_path)
      
    end
  
   
  end