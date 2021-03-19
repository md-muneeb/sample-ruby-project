require "rails_helper"

RSpec.describe "Fish", :type => :request do
    it "returns all fish" do
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

end