class Api::DinosaursController < ApplicationController
  before_action :find_dinosaur, only: [:show, :update, :destroy]

  def index
    @dinosaurs = Dinosaur.all
    if params[:species]
      @dinosaurs = @dinosaurs.where(species: Species.where('lower(name) = ?', (params[:species].downcase)))
    end
  end

  def show
  end

  def create
    @dinosaur = Dinosaur.new(dinosaur_params)

    unless @dinosaur.save
      render json: @dinosaur.errors, status: :unprocessable_entity
    end
  end

  def update
    unless @dinosaur.update(dinosaur_params)
      render json: @dinosaur.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @dinosaur.destroy
      render json: { message: 'Successful deletion' }, status: :accepted
    else
      render json: @dinosaur.errors, status: :unprocessable_entity
    end
  end

  private

  def find_dinosaur
    @dinosaur = Dinosaur.find_by_id params[:id]

    unless @dinosaur
      render json: { error: 'No Dinosaur Found' }, status: :not_found
    end
  end

  def dinosaur_params
    params.require(:dinosaur).permit(
      :name,
      :cage_id,
      :species_id,
    )
  end
end
