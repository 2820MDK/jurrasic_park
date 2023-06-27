require 'rails_helper'

RSpec.describe Api::DinosaursController, type: :controller do
  render_views

  before :each do
    @tyrannosaurus = FactoryBot.create(:species, name: "Tyrannosaurus", diet: :carnivore)
    @cage = FactoryBot.create(:cage)
  end

  describe "GET /index" do
    it 'returns a successful response' do
      get :index

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns data about the dinosaurs' do
      FactoryBot.create_list(:dinosaur, 8, species: @tyrannosaurus, cage: @cage)

      get :index
      data = JSON.parse(response.body)
      expect(data.count).to eq(8)
    end
  end

  describe 'GET /:id' do
    before :each do
      @dinosaur = FactoryBot.create(:dinosaur, cage: @cage, species: @tyrannosaurus)
    end

    it 'returns an error message with a bad id' do
      get :show, params: { id: 'random' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Dinosaur Found")
    end

    it 'returns a succesful respone when given a good id' do
      get :show, params: { id: @dinosaur.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns data about the dinosaur' do
      get :show, params: { id: @dinosaur.id }
      dinosaur = JSON.parse(response.body)
      expect(dinosaur["name"]).to eq(@dinosaur.name)
      expect(dinosaur["species"]["name"]).to eq(@dinosaur.species.name)
      expect(dinosaur["cage"]).to eq(@dinosaur.cage.name)
    end
  end

  describe 'POST /dinosaurs create' do
    let(:dinosaur_params) do
      {
        dinosaur: {
          name: "Test Dinosaur",
          cage_id: @cage.id,
          species_id: @tyrannosaurus.id
        }
      }
    end

    it 'saves the dinosaur with the right params' do
      post :create, params: dinosaur_params
      expect(response.status).to eq(200)

      cage = JSON.parse(response.body)
      expect(cage['name']).to eq('Test Dinosaur')
    end

    it 'renders errors when necessary' do
      post :create, params: {
        dinosaur: { name: nil }
      }

      expect(response.status).to eq(422)
      data = JSON.parse(response.body)
      expect(data['name']).to eq(["can't be blank"])
    end
  end

  describe 'PUT /dinosaurs/:id update' do
    before :each do
      @dinosaur = FactoryBot.create(:dinosaur, cage: @cage, species: @tyrannosaurus)
    end

    let(:dinosaur_params) do
      {
        id: @dinosaur.id,
        dinosaur: {
          id: @dinosaur.id,
          name: "Test Dinosaur",
        }
      }
    end

    it 'saves the dinosaur with the right params' do
      put :update, params: dinosaur_params
      expect(response.status).to eq(200)

      dinosaur = JSON.parse(response.body)
      expect(dinosaur['name']).to eq('Test Dinosaur')
    end

    it 'renders errors when necessary' do
      put :update, params: {
        id: @dinosaur.id,
        dinosaur: { name: nil }
      }

      expect(response.status).to eq(422)
      data = JSON.parse(response.body)
      expect(data['name']).to eq(["can't be blank"])
    end

    it 'returns an error message with a bad id' do
      get :show, params: { id: 'random' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Dinosaur Found")
    end

  end

  describe 'DELETE /dinosaurs/:id destroy' do
    before :each do
      @dinosaur = FactoryBot.create(:dinosaur, cage: @cage, species: @tyrannosaurus)
    end

    it 'destorys the dinosaur with the right params' do
      delete :destroy, params: { id: @dinosaur.id }

      expect(response.status).to eq(202)
      expect(Dinosaur.find_by_id @dinosaur.id).to be_nil
    end

    it 'returns an error message with a bad id' do
      delete :destroy, params: { id: 'nope' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Dinosaur Found")
    end
  end
end
