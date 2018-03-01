class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    profile = Profile.create(user_id: resource.id)
    ProfileImage.create(user_id: resource.id, profile_id: profile.id, image: '', caption: '')
  end
  
  def edit
    if params.present? && params[:mode].present?
      @mode = params[:mode]
    else
      @mode = "email"
    end
    super
  end
  def update
    @mode = params[:mode]
    super
  end
  protected
  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end
  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
    resource.pending_reconfirmation? &&
    resource.email != resource.unconfirmed_email
  end
end
