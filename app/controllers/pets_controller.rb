class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]
  before_action :set_pet, only: [ :show, :edit, :destroy ]
  before_action :pet_params, only: [ :create ]
  # before_action :find_user


  def index
    @pets = Pet.where(available: true)
  end

  # para display o formulario de adoption no shoe do pet
  def show
    @adoption = Adoption.new
  end

  def adoptions_pet
    @pet = Pet.find(params[:id])
    # @adoption. = @pet.adoption
    # @pet.user = current_user
    @adoptions = Adoption.where(pet_id: @pet.id)
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
      render :new
    end
  end

  def owner
    # @pets = Pet.where(user_id: current_user.id)
    @pets_available = Pet.where(user_id: current_user.id, available: true)
    @pets_adopted = Pet.includes(:adoptions).where(adoptions: {approved: true}, user_id: current_user.id) # todos adotados e indisponiveis
    @pets_unavailable = Pet.where(user_id: current_user.id, available: false) # todos indisponíveis
    
    @pets_dead = @pets_unavailable - @pets_adopted

  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    
    @adoption = @pet.adoptions.find_by(approved: true)
    @adoption.update(approved: false) if @pet.available && @adoption

    redirect_to owner_pets_path(@pet)
  end

  def destroy
    @pet.destroy
    redirect_to owner_pets_path
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :age, :size, :breed, :available, :user_id, :photo)
  end

 
  # def find_user
  #   @user = current_user
  # end


end
