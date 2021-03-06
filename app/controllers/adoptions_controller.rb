class AdoptionsController < ApplicationController

  def index
    @adoptions = Adoption.all
  end

  def create
    @adoption = Adoption.new(adoption_params)
    @adoption.user = current_user
    @adoption.pet_id = params[:pet_id] # pegando o id do pet a partir da url (lembrar das rotas)
    @adoption.save
    redirect_to pet_path(@adoption.pet_id), notice: "Você se candidatou a adoção, aguarde aprovação!" 
  end

  def update
    @adoption = Adoption.find(params[:id])
    @adoption.update(adoption_params)
    @pet = @adoption.pet
    @pet.update(available: false) if @adoption.approved 
    redirect_to owner_pets_path
  end

  private

  # passar os parametros para preenche o comentario e vincular o id
  def adoption_params
    params.require(:adoption).permit(:comment, :approved)
  end
end
