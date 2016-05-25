class PokemonsController < ApplicationController
 load_and_authorize_resource
 before_action :check_minimum, only: [:index]
 before_action :authenticate_user!, only: [:new, :create, :update, :destroy]

 def index
 	@pokemons = Pokemon.paginate(page: params[:page], per_page:10)
 	 					.includes(:type, :moves)
 end
 def show
 end
 def new
 end
 def create
 	@pokemon = Pokemon.new pokemon_params
 	if @pokemon.save
 		redirect_to @pokemon
 	else
 		render 'new'
 	end
 end
 def edit
 end
 def update
 	if @pokemon.update pokemon_params
 		redirect_to @pokemon
 	else
 		render 'edit'
 	end
 end
 def destroy
 	@pokemon.destroy
 	redirect_to pokemons_path
 end
end


private

def pokemon_params
	params.require(:pokemon).permit(
		:name,
		:number,
		:level,
		:health_points,
		:type_id,
    :avatar,
		move_ids: []
		)
end

def set_pokemon
	@pokemon = Pokemon.find params[:id]
end
def check_minimum
	count = Pokemon.count
	limit = 5
	flash['danger'] = "Attention il y a moins de #{limit} Pokemons" if count < limit
end
