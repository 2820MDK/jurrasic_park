require 'rails_helper'

RSpec.describe Api::SpeciesController, type: :controller do
  render_views

  before :each do
    Species.destroy_all
    @species = FactoryBot.create(:species, name: "Tyrannosaurus", diet: :carnivore)
    FactoryBot.create(:species, name: "Brachiosaurus", diet: :herbivore)
  end

  describe "GET /index" do
    it 'returns a successful response' do
      get :index

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns data about the species' do
      get :index
      data = JSON.parse(response.body)
      expect(data.count).to eq(2)
    end
  end

  describe 'GET /:id' do
    it 'returns an error message with a bad id' do
      get :show, params: { id: 'random' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Species Found")
    end

    it 'returns a succesful respone when given a good id' do
      get :show, params: { id: @species.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns data about the species' do
      get :show, params: { id: @species.id }
      species = JSON.parse(response.body)
      expect(species["name"]).to eq(@species.name)
      expect(species["diet"]).to eq(@species.diet)
    end
  end

  describe 'POST /species create' do
    let(:species_params) do
      {
        species: {
          name: "Test Species",
          diet: "herbivore"
        }
      }
    end

    it 'saves the species with the right params' do
      post :create, params: species_params
      expect(response.status).to eq(200)

      species = JSON.parse(response.body)
      expect(species['name']).to eq('Test Species')
      expect(species['diet']).to eq('herbivore')
    end
  end

  describe 'PUT /species/:id update' do
    let(:species_params) do
      {
        id: @species.id,
        species: {
          id: @species.id,
          name: "new name",
        }
      }
    end

    it 'saves the species with the right params' do
      put :update, params: species_params
      expect(response.status).to eq(200)

      species = JSON.parse(response.body)
      expect(species['name']).to eq('new name')
      expect(species['diet']).to eq(@species.diet)
    end

    it 'renders errors when necessary' do
      put :update, params: {
        id: @species.id,
        species: { name: nil }
      }

      expect(response.status).to eq(422)
      data = JSON.parse(response.body)
      expect(data['name']).to eq(["can't be blank"])
    end

    it 'returns an error message with a bad id' do
      get :show, params: { id: 'random' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Species Found")
    end
  end

  describe 'DELETE /species/:id destroy' do
    it 'destorys the cage with the right params' do
      delete :destroy, params: { id: @species.id }

      expect(response.status).to eq(202)
      expect(Species.find_by_id @species.id).to be_nil
    end

    it 'returns an error message with a bad id' do
      delete :destroy, params: { id: 'nope' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Species Found")
    end
  end
end
