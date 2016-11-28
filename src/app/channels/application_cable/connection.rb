module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :verified_user

    def connect
     self.verified_user = find_verified_user
#      logger.add_tags 'ActionCable', current_user.email
    end

    protected

    def find_verified_user # this checks whether a user is authenticated with devise
      # p 'cookie user: ' + cookies.signed[:remember_token_cookie].to_s
      # p 'cookie user clearance: ' + cookies.inspect
      if env[:clearance].signed_in?
        p 'chap nhan roi nhe'
        verified_user = env[:clearance].current_user
      else
        p 'reject roi nhe'
      	reject_unauthorized_connection          
      end
    end
  end
end

