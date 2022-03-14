require "rails_helper"

RSpec.describe PostsController, type: :controller do
  let(:user) { User.create(first_name: "Bob", last_name: "Smith") }
  let(:default_text) { "default" }
  let(:default_post) { Post.create(user: user, text: default_text) }
  
  before do
    default_post.save!
  end

  # GET /users/:id/posts
  describe "GET index" do
    it "has a 200 status code" do
      get :index, params: { user_id: default_post.user_id }
      expect(response.status).to eq(200)
    end
  end

  # POST /users/:id/posts
  describe "POST create" do
    it "has a 201 status code" do
      post :create, params: { user_id: user.id, post: { text: "created" } }, format: :json
      expect(response.status).to eq(201)
    end

    it "increments POST count by 1" do
      expect {
        post :create, params: { user_id: user.id, post: { text: "created" } }, format: :json
      }.to change { Post.count }.by(1)
    end
  end

  # GET /posts/:id
  describe "GET show" do
    it "has a 200 status code" do
      get :show, params: { id: default_post.id }
      expect(response.status).to eq(200)
    end

    # The Rails stack returns a 404 response when a controller action raises RecordNotFound
    it "raises RecordNotFound when the resource doesn't exist" do
      expect {
        get :show, params: { id: "invalid" }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  # DELETE /posts/:id
  describe "DELETE destroy" do
    it "has a 204 status code" do
      delete :destroy, params: { id: default_post.id }
      expect(response.status).to eq(204)
    end

    it "decrements POST count by 1" do
      expect {
        delete :destroy, params: { id: default_post.id }
      }.to change { Post.count }.by(-1)
    end
  end

  # PATCH /posts/:id
  describe "Update a post" do
    let(:updated_text) { "updated" }

    it "has a 200 status code" do
      patch :update, params: { id: default_post.id, post: { text: updated_text } }, format: :json
      expect(response.status).to eq(200)
    end

    it "doesn't change the Post count" do
      expect {
        patch :update, params: { id: default_post.id, post: { text: updated_text } }, format: :json
      }.not_to change { Post.count }
    end

    it "updates the resource" do
      expect {
        patch :update, params: { id: default_post.id, post: { text: updated_text } }, format: :json
      }.to change { Post.find(default_post.id).text }.from(default_text).to(updated_text)
    end
  end
end
