require 'rails_helper'

RSpec.describe Api::CagesController, type: :controller do
  render_views

  before :each do
    @tyrannosaurus = FactoryBot.create(:species, name: "Tyrannosaurus", diet: :carnivore)
    @brachiosaurus = FactoryBot.create(:species, name: "Brachiosaurus", diet: :herbivore)
  end

  describe "GET /index" do
    before :each do
      @cage1 = FactoryBot.create(:cage)
      @cage2 = FactoryBot.create(:cage)
    end

    it 'returns a successful response' do
      get :index

      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns data about the cages and dinosaurs' do
      FactoryBot.create_list(:dinosaur, 8, species: @tyrannosaurus, cage: @cage1)
      FactoryBot.create_list(:dinosaur, 8, species: @brachiosaurus, cage: @cage2)

      get :index
      data = JSON.parse(response.body)
      expect(data.count).to eq(2)
    end

    it 'can filter by has_power' do
      @cage1.update(has_power: false)

      get :index, params: {has_power: "false"}
      data = JSON.parse(response.body)
      expect(data.count).to eq(1)
    end
  end

  describe 'GET /:id' do
    before :each do
      @cage = FactoryBot.create(:cage)
      FactoryBot.create_list(:dinosaur, 8, species: @tyrannosaurus, cage: @cage)
    end

    it 'returns an error message with a bad id' do
      get :show, params: { id: 'random' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Cage Found")
    end

    it 'returns a succesful respone when given a good id' do
      get :show, params: { id: @cage.id }
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'returns data about the cage' do
      get :show, params: { id: @cage.id }
      cage = JSON.parse(response.body)
      expect(cage["name"]).to eq(@cage.name)
      expect(cage["has_power"]).to eq(@cage.has_power)
      expect(cage["capacity"]).to eq(@cage.capacity)
      expect(cage["dinosaurs"].count).to eq(8)
    end
  end

  describe 'POST /cages create' do
    let(:cage_params) do
      {
        cage: {
          name: "Test Cage",
          capacity: 25,
          has_power: true,
          dinosaurs_attributes: [
            { name: 'Bob', species_id: @tyrannosaurus.id },
            { name: 'Carl', species_id: @tyrannosaurus.id },
          ]
        }
      }
    end

    it 'saves the cage with the right params' do
      post :create, params: cage_params
      expect(response.status).to eq(200)

      cage = JSON.parse(response.body)
      expect(cage['name']).to eq('Test Cage')
      expect(cage['capacity']).to eq(25)
      expect(cage['has_power']).to eq(true)
      expect(cage['dinosaurs'].count).to eq(2)
    end

    it 'renders errors when necessary' do
      post :create, params: {
        cage: { capacity: 22, has_power: false}
      }

      expect(response.status).to eq(422)
      data = JSON.parse(response.body)
      expect(data['name']).to eq(["can't be blank"])
    end
  end

  describe 'PUT /cages/:id update' do
    before :each do
      @cage = FactoryBot.create(:cage, name: "Update Cage", capacity: 12)
    end

    let(:cage_params) do
      {
        id: @cage.id,
        cage: {
          id: @cage.id,
          name: "Test Cage",
          capacity: 25,
          has_power: true,
          dinosaurs_attributes: [
            { name: 'Bob', species_id: @tyrannosaurus.id },
            { name: 'Carl', species_id: @tyrannosaurus.id },
          ]
        }
      }
    end

    it 'saves the cage with the right params' do
      put :update, params: cage_params
      expect(response.status).to eq(200)

      cage = JSON.parse(response.body)
      expect(cage['name']).to eq('Test Cage')
      expect(cage['capacity']).to eq(25)
      expect(cage['has_power']).to eq(true)
      expect(cage['dinosaurs'].count).to eq(2)
    end

    it 'renders errors when necessary' do
      put :update, params: {
        id: @cage.id,
        cage: { name: nil, capacity: 22, has_power: false}
      }

      expect(response.status).to eq(422)
      data = JSON.parse(response.body)
      expect(data['name']).to eq(["can't be blank"])
    end

    it 'returns an error message with a bad id' do
      get :show, params: { id: 'random' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Cage Found")
    end

    it "can't be turned off with dinosaurs" do
      cage = FactoryBot.create(:cage)
      FactoryBot.create(:dinosaur, cage: cage)

      put :update, params: {
        id: cage.id,
        cage: { has_power: false}
      }

      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)['has_power']).to eq(["can't turn off with dinosaurs in cage!"])
    end

  end

  describe 'DELETE /cages/:id destroy' do
    before :each do
      @cage = FactoryBot.create(:cage, name: "Update Cage", capacity: 12)
      @dino = FactoryBot.create(:dinosaur, cage: @cage)
    end

    it 'destorys the cage with the right params' do
      delete :destroy, params: { id: @cage.id }

      expect(response.status).to eq(202)
      expect(Cage.find_by_id @cage.id).to be_nil
    end

    it 'returns an error message with a bad id' do
      delete :destroy, params: { id: 'nope' }
      expect(response.status).to eq(404)

      expect(JSON.parse(response.body)['error']).to eq("No Cage Found")
    end
  end
end
