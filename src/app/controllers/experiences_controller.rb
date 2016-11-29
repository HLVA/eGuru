class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
   skip_before_filter :verify_authenticity_token
   skip_before_action :require_login, only: [:index, :show]

  # GET /experiences
  # GET /experiences.json
  def index
  
    if params[:search]
    @experiences = Experience.search(params[:search]).order("created_at DESC")
  else
    @experiences = Experience.all.order(params[:sort])

  end
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
    @experience= Experience.find(params[:id])
    # @photo= Photo.find(@experience.photo_id)

  end

  # GET /experiences/new
  def new
    @photo1= Photo.last
    @experience = Experience.new
    @experience.photos.new
    @photo= Photo.new

    uploader = AvatarUploader.new
  end

  # GET /experiences/1/edit
  def edit
  end

  # POST /experiences
  # POST /experiences.json
  def create
    @experience = Experience.new(experience_params)
    count = 0;
    respond_to do |format|
      if @experience.save
        # if params[:experience][:photos_attributes]

        #   params[:experience][:photos_attributes].each do |photo|
        #     count = count+1
        #     @experience.photos.create(avatar: photo[:avatar])
        #   end

        # end
        format.html { redirect_to @experience, notice: 'Experience was successfully created.' }
        format.json { render :show, status: :created, location: @experience }

      else
        format.html { render :new }
        format.json { render json: @experience.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /experiences/1
  # PATCH/PUT /experiences/1.json
  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.json
  def destroy
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_url, notice: 'Experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:title, :content, :location, :rating, :user_id, :category_id, :tag_id, :report , :photo_id, :photos_attributes => [:avatar])
    end
end
