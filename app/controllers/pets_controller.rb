class PetsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show]
  before_action :set_pet, only: [ :show, :edit, :destroy ]
  before_action :pet_params, only: [ :create ]
  # before_action :find_user


  def index
    @pets = Pet.all
  end

  # para display o formulario de adoption no shoe do pet
  def show
    @adoption = Adoption.new
    # if @pet.user_id == current_user.id
    #   redirect_to pet_adoptions_path
    # else
    #   redirect_to pet_path
    # end
  end

  def adoptions_pet
    @pet = Pet.find(params[:id])
    # @adoption. = @pet.adoption
    # @pet.user = current_user
    @adoptions = Adoption.where(pet_id: @pet.id)
    @adoption = Adoption.new
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
    @pets = Pet.where(user_id: current_user.id)
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    redirect_to adoptions_pet_pet_path(@pet)
  end

  def destroy
    raise
    @pet.destroy
    redirect_to owner_pets_path
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :age, :size, :breed, :available, :user_id)
  end

  # def find_user
  #   @user = current_user
  # end


end
