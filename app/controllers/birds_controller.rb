class BirdsController < ApplicationController
  #prevent json default of wrapping json parameters as nested hash under a key controller - which can attract unpermitted parameters passing
  wrap_parameters format: []

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    #bird = Bird.create(name: params[:name], species: params[:species])
    #update the create method as follows- use strong params to only permit the parameters that we want to use
    #bird = Bird.create(params)- this will attract mass assignment vulnerability
   # bird = Bird.create(params.permit(:name, :species))
   #refactor as follows
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end
  
  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  private
  # all methods below here are private

  def bird_params
    params.permit(:name, :species)
  end

end
