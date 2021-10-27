class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]
  before_action :set_pet, only: [ :show ]
  before_action :pet_params, only: [ :create ]
  # before_action :find_user


  def index
    @pets = Pet.all
  end

  def show
    
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.valid?
      @pet.save
      redirect_to owner_pets_path
    else
      render :name
    end
  end

  def owner
    # @user_id = current_user.id
    # @user = current_user
    # @pet.user_id = current_user.id

    @pets = Pet.where(user_id: current_user.id)
  end



  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :age, :size, :breed, :status, :user_id)
  end

  # def find_user
  #   @user = current_user
  # end


end
