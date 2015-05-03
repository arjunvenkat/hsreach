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
    @school.rank = params[:rank]
    @school.tier1_score = params[:tier1_score]
    @school.tier2_score = params[:tier2_score]
    @school.tier3_score = params[:tier3_score]
    @school.tier4_score = params[:tier4_score]
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
    @school.rank = params[:rank]
    @school.tier1_score = params[:tier1_score]
    @school.tier2_score = params[:tier2_score]
    @school.tier3_score = params[:tier3_score]
    @school.tier4_score = params[:tier4_score]
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
