class Api::SpeciesController < ApplicationController
  before_action :find_species, only: [:show, :update, :destroy]

  def index
    @species = Species.all
  end

  def show
  end

  def create
    @species = Species.new(species_params)

    unless @species.save
      render json: @species.errors, status: :unprocessable_entity
    end
  end

  def update
    unless @species.update(species_params)
      render json: @species.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @species.destroy
      render json: { message: 'Successful deletion' }, status: :accepted
    else
      render json: @species.errors, status: :unprocessable_entity
    end
  end

  private

  def find_species
    @species = Species.find_by_id params[:id]

    unless @species
      render json: { error: 'No Species Found' }, status: :not_found
    end
  end

  def species_params
    params.require(:species).permit(
      :name,
      :id,
      :diet,
    )
  end
end
