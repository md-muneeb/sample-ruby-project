require "rails_helper"

RSpec.describe "Item", :type => :request do
    it "return all items" do
        get items_path
        expect(response).to have_http_status(:success)
    end

    it "successfully creates a new item and redirects to index page" do
        get new_item_path
        expect(response).to render_template(:new)
        fish = FactoryBot.create(:fish, name: "Shark", age: 2)
        post items_path, :params => { :item => { :name => "Bread", :desc => "Grocery", :cost => 2.25, :fish_id => fish.id }}
        expect(response).to redirect_to(items_path)
    end

    it "does not creates a new item because of failed validations" do
        get new_item_path
        expect(response).to render_template(:new)
        post items_path, :params => { :item => { :name => "Bread", :desc => "Grocery", :cost => -2.25 }}
        expect(response).to render_template("new")
    end

    it "successfully updates an item and redirects to index page" do
        fish = FactoryBot.create(:fish, name: "Shark", age: 2)
        item = FactoryBot.create(:item, :name => "Bread", :desc => "Grocery", :cost => 2.25, :fish_id => fish.id )
        get "/items/#{item.id}/edit"
        expect(response).to render_template(:edit)
        put "/items/#{item.id}", :params => { :item => { :name => "Bread", :desc => "Grocery", :cost => 3.25, :fish_id => fish.id }}
        expect(response).to redirect_to(items_path)
    end

    it "does not updates an item due to failed validation" do
        fish = FactoryBot.create(:fish, name: "Shark", age: 2)
        item = FactoryBot.create(:item, :name => "Milk", :desc => "Dairy", :cost => 2.25, :fish_id => fish.id)
        get "/items/#{item.id}/edit"
        expect(response).to render_template(:edit)
        put "/items/#{item.id}", :params => { :item => { :name => "Milk", :desc => "Dairy", :cost => -2.25, :fish_id => fish.id }}
        expect(response).to render_template("edit")
    end

    it "delete item when given valid id" do
        fish = FactoryBot.create(:fish, name: "Shark", age: 2)
        item = FactoryBot.create(:item, :name => "Milk", :desc => "Dairy", :cost => 2.25, :fish_id => fish.id)
        delete "/items/#{item.id}"
        expect(response).to redirect_to(items_path)
    end

    it "does not delete item when given invalid id" do
        delete "/items/99"
        expect(response).to have_http_status(404)
    end

end