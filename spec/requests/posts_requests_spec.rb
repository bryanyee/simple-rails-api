require "rails_helper"

# 404 behavior - when a resource doesn't exist:
# - #find and #find_by_id! will raise ActiveRecord::RecordNotFound,
#   and the Rails stack automatically returns a 404 response
# - rspec controller and request specs don't include the RecordNotFound/404 handler,
#   so test against RecordNotFound directly, configure a workaround, or use feature integration tests
# - https://stackoverflow.com/questions/24786258/rspec-rails-controller-testing-404-not-working

RSpec.describe "API calls on the posts resource", type: :request do
  let(:user) { User.create(first_name: "Bob", last_name: "Smith") }
  let(:default_text) { "default" }
  let(:default_post) { Post.create(user: user, text: default_text) }

  before do
    default_post.save!
  end

  # GET /users/:id/posts
  describe "Find user posts" do
    it "has a 200 status code" do
      get user_posts_path(user_id: default_post.user_id)
      expect(response.status).to eq(200)
    end
  end

  # POST /users/:id/posts
  describe "Create a user post" do
    let(:headers) {{ "Content-Type" => "application/json" }}
    let(:body) {{ text: "created" }}

    it "has a 201 status code" do
      post user_posts_path(user_id: user.id), params: body.to_json, headers: headers
      expect(response.status).to eq(201)
    end

    it "increments POST count by 1" do
      expect {
        post user_posts_path(user_id: user.id), params: body.to_json, headers: headers
      }.to change { Post.count }.by(1)
    end
  end

  # GET /posts/:id
  describe "Find a post" do
    it "has a 200 status code" do
      get post_path(default_post.id)
      expect(response.status).to eq(200)
    end

    # The Rails stack returns a 404 response when a controller action raises RecordNotFound
    it "raises RecordNotFound when the resource doesn't exist" do
      expect {
        get post_path('invalid')
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  # DELETE /posts/:id
  describe "Delete a post" do
    it "has a 204 status code" do
      delete post_path(default_post.id)
      expect(response.status).to eq(204)
    end

    it "decrements POST count by 1" do
      expect {
        delete post_path(default_post.id)
      }.to change { Post.count }.by(-1)
    end
  end

  # PATCH /posts/:id
  describe "Update a post" do
    let(:headers) {{ "Content-Type" => "application/json" }}
    let(:updated_text) { "updated" }
    let(:body) {{ text: updated_text }}

    it "has a 200 status code" do
      patch post_path(default_post.id), params: body.to_json, headers: headers
      expect(response.status).to eq(200)
    end

    it "doesn't change the Post count" do
      expect {
        patch post_path(default_post.id), params: body.to_json, headers: headers
      }.not_to change { Post.count }
    end

    it "updates the resource" do
      expect {
        patch post_path(default_post.id), params: body.to_json, headers: headers
      }.to change { Post.find(default_post.id).text }.from(default_text).to(updated_text)
    end
  end
end
