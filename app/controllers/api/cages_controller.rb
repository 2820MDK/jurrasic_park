class Api::CagesController < ApplicationController
  def index
    @cages = Cage.all
  end

  def show
    @cage = Cage.find_by_id params[:id]

    unless @cage
        render json: { error: 'No Cage Found' }, status: :not_found
    end
  end

  def create
    @cage = Cage.new(cage_params)

    unless @cage.save
      render json: @cage.errors, status: :unprocessable_entity
    end
  end

  private

  def cage_params
    params.require(:cage).permit(
      :name,
      :capacity,
      :has_power,
      dinosaurs_attributes: [:name, :species_id]
    )
  end
end
