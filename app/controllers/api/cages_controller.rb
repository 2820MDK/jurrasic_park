class Api::CagesController < ApplicationController
  before_action :find_cage, only: [:show, :update]

  def index
    @cages = Cage.all
  end

  def show
  end

  def create
    @cage = Cage.new(cage_params)

    unless @cage.save
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  def update
    unless @cage.update(cage_params)
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  private

  def find_cage
    @cage = Cage.find_by_id params[:id]

    unless @cage
        render json: { error: 'No Cage Found' }, status: :not_found
    end
  end

  def cage_params
    params.require(:cage).permit(
      :name,
      :capacity,
      :has_power,
      dinosaurs_attributes: [:name, :species_id]
    )
  end
end
