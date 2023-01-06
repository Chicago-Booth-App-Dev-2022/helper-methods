class DirectorsController < ApplicationController

  def new
    @director = Director.new

  end

  def index

    @directors = Director.order(created_at: :desc)

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html
    end
  end

  def show

    @director = Director.find(params.fetch(:id))

  end

  def create

    director_attributes = params.require(:director).permit(:name, :dob, :hometown)

    @director = Director.new(director_attributes)

    if @director.valid?
      @director.save
      redirect_to directors_url, notice: "Director created successfully."
    else
      render "new"
    end
  end

  def edit

    @director = Director.find(params.fetch(:id))

  end

  def update
    
    @director = Director.find(params.fetch(:id))
    
    director_attributes = params.require(:director).permit(:name, :dob, :hometown)

    @director.name = director_attributes.fetch("name")
    @director.dob = director_attributes.fetch("dob")
    @director.hometown = director_attributes.fetch("hometown")

    if @director.valid?
      @director.save
      redirect_to director_url(@director), notice: "Director updated successfully." 
    else
      redirect_to director_url(@director), alert: "Director failed to update successfully."
    end
  end

  def destroy
    @director = Director.find(params.fetch(:id))

    @director.destroy

    redirect_to directors_url, notice: "Director deleted successfully."
  end
end
