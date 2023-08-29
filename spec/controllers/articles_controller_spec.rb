require "rails_helper"

RSpec.describe ArticlesController, type: :controller do

	before(:each) do
		@user = create(:user)
		@article = create(:article, user_id: @user.id)
		9.times do
			article = create(:article, user_id: @user.id)
		end
	end

  describe "GET #index" do
    it "should return all articles" do
      get :index
      expect(response).to have_http_status :ok
      expect(JSON.parse(response.body)["articles"]["data"].size).to be == 10
    end
  end

  describe "GET #show" do
    it "should return article" do
      get :show, params: { id: @article.id }
      expect(response).to have_http_status :ok
			expect(JSON.parse(response.body)["article"]["data"]["attributes"]["title"]).to eql @article.title
			expect(JSON.parse(response.body)["article"]["data"]["attributes"]["body"]).to eql @article.body
    end

    it "should return article not found" do
      get :show, params: { id: 1000 }
      expect(response).to have_http_status :not_found
			expect(JSON.parse(response.body)["error"]).to eql "Article not found"
    end
  end

	describe "POST #create" do
		let(:create_article) { { data: { title: Faker::Lorem.sentence(word_count: 3), body: Faker::Lorem.sentence(word_count: 30), user_id: @user.id }}}
		it "should create new article" do
			post :create, params: create_article
			expect(response).to have_http_status :created
		end

		let(:invalid_params) { { data: { title: Faker::Lorem.sentence(word_count: 3), body: Faker::Lorem.sentence(word_count: 30) }}}
		it "should raise error due to NULL user" do
			post :create, params: invalid_params
			expect(response).to have_http_status :unprocessable_entity
			expect(JSON.parse(response.body)["errors"][0]).to eql "User must exist"
		end
	end

	describe "PUT #update" do

		let(:new_title) { Faker::Lorem.sentence(word_count: 3) }
		let(:update_params) {{ data: { title: new_title }, id: @article.id }}
		it "should update article" do
			put :update, params: update_params
			expect(response).to have_http_status :ok
			expect(JSON.parse(response.body)["article"]["data"]["attributes"]["title"]).to eql new_title
			expect(JSON.parse(response.body)["article"]["data"]["attributes"]["body"]).to eql @article.body
		end
	end

	describe "DELETE #destroy" do

		let(:article) { create(:article, user_id: @user.id) }
		it "should delete article" do
			delete :destroy, params: { id: article.id }
			expect(response).to have_http_status :ok
			expect(JSON.parse(response.body)["message"]).to eql "Article successfully deleted"

			delete :destroy, params: { id: article.id }
			expect(response).to have_http_status :not_found
			expect(JSON.parse(response.body)["error"]).to eql "Article not found"
		end
	end

end