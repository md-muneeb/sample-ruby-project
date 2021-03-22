require "rails_helper"

RSpec.describe "Fish", :type => :request do
    it "return all fish" do
        get fishes_path
        expect(response).to have_http_status(:success)
    end

    it "successfully creates a new fish and redirects to index page" do
        get new_fish_path
        expect(response).to render_template(:new)
        post fishes_path, :params => { :fish => { :name => "Goldfish", :age => 2 }}
        expect(response).to redirect_to(fishes_path)
    end

    it "does not creates a new fish because of failed validations" do
        get new_fish_path
        expect(response).to render_template(:new)
        post fishes_path, :params => { :fish => { :name => "Goldfish", :age => -4 }}
        expect(response).to render_template("new")
    end

    it "successfully updates a fish and redirects to index page" do
        fish = FactoryBot.create(:fish, name: "Shark", age: 2)
        get "/fishes/#{fish.id}/edit"
        expect(response).to render_template(:edit)
        put "/fishes/#{fish.id}", :params => { :fish => { :name => "Goldfish", :age => 4 }}
        expect(response).to redirect_to(fishes_path)
    end

    it "does not updates a fish due to failed validation" do
        fish = FactoryBot.create(:fish, name: "Shark", age: 2)
        get "/fishes/#{fish.id}/edit"
        expect(response).to render_template(:edit)
        put "/fishes/#{fish.id}", :params => { :fish => { :name => "Goldfish", :age => -4 }}
        expect(response).to render_template("edit")
    end

    it "delete fish when given valid id" do
        fish = FactoryBot.create(:fish, name: "Shark", age: 2)
        delete "/fishes/#{fish.id}"
        expect(response).to redirect_to(fishes_path)
    end

    it "does not delete fish when given invalid id" do
        delete "/fishes/99"
        expect(response).to have_http_status(404)
    end

end