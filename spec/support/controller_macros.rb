module ControllerMacros
  def set_devise_mapping_to_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
	end
end