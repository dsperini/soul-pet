class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]
  before_action :set_pet, only: [ :show ]


  def index
    @pets = Pet.all
  end

  def show
    
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end


end
