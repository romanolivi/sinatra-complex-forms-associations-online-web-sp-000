class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params["owner"]["name"].empty?
      @owner = Owner.create(name: params["owner"]["name"])
    else 
      @owner = Owner.find(params["owner"]["id"])
    end
      @pet = Pet.create(name: params["pet"]["name"], owner: @owner)
      redirect to "/pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end
  
  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet_name]
    if params["owner"]["name"].empty?
      @owner = Owner.find(params[:owner_id])
    else 
      @owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.owner = @owner
    @pet.save 
    redirect to "/pets/#{@pet.id}"
  end
end