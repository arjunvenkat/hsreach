class SchoolsController < ApplicationController
  def index
    @schools = School.all
  end

  def show
    @school = School.find(params[:id])
  end

  def new
    @school = School.new
  end

  def create
    @school = School.new
    @school.name = params[:name]
    @school.avg_score = params[:avg_score]
    @school.category = params[:category]
    @school.address = params[:address]
    @school.lat = params[:lat]
    @school.long = params[:long]

    if @school.save
      redirect_to schools_url, :notice => "School created successfully."
    else
      render 'new'
    end
  end

  def edit
    @school = School.find(params[:id])
  end

  def update
    @school = School.find(params[:id])

    @school.name = params[:name]
    @school.avg_score = params[:avg_score]
    @school.category = params[:category]
    @school.address = params[:address]
    @school.lat = params[:lat]
    @school.long = params[:long]

    if @school.save
      redirect_to school_url(@school.id), :notice => "School updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @school = School.find(params[:id])

    @school.destroy

    redirect_to schools_url, :notice => "School deleted."
  end
end
