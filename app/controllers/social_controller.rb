class SocialController < ApplicationController
  
  before_action :distance, only: [:around]
  before_action :profile, only: [:around]
  
  def around_form
    
  end
  
  def around
    if @profile.nil?
      error = 'profile_id missing'
      respond_to do |format|
        format.html { redirect_to social_around_form_path, notice: error }
        format.json { render json: { error: error }, status: :bad_request }
      end
      return
    end
    
    @profiles = Profile.within(@distance, origin: @profile)
    @profiles.each do |profile|
      puts profile
    end
  end
  
  private
    def distance
      @distance = params[:distance]
      @distance ||= 10
    end
    
    def profile
      @profile = Profile.find(params[:profile_id]) if params[:profile_id]
    end
  
end
