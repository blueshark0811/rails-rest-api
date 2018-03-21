module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def current_user
      return @current_user if @current_user

      token = params[:data][:authorization].to_s.split(' ').last

      @current_user = User.find_by_token(token)
    end

    def current_organization
      @current_organization ||= current_user.organizations
        .find(params[:organization_id] || params[:data][:organization_id])
    end
  end
end
