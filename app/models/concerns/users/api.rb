module Users
  module Api
    extend ActiveSupport::Concern

    included do
    end

    def remember_expired?
      !remember_created_at || remember_expire_at < Time.zone.now
    end

    def remember_expire_at
      return unless remember_created_at

      remember_created_at + self.class.remember_for
    end

    def jwt_token
      return unless confirmed?

      remember_me!

      JWT.encode(
        {
          id: id,
          exp: remember_expires_at.to_i,
          type: self.class.name.to_s.downcase,
          email: email
        },
        APP_CONFIG['api']['jwt']['secret'], APP_CONFIG['api']['jwt']['algorithm']
      )
    end

    module ClassMethods
      def find_by_token token
        return if token.blank?
        
        begin
          attrs = JWT.decode token, APP_CONFIG['api']['jwt']['secret'], APP_CONFIG['api']['jwt']['algorithm']
        rescue JWT::DecodeError
          return
        end

        if (user = User.find_by(id: attrs.first['id'])) && !user.remember_expired?
          return user
        end

        nil
      end
    end
  end
end
