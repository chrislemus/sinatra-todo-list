class Helpers < ActiveRecord::Base
  self.abstract_class = true

  def self.logged_in?(session)
    !!current_user(session)
  end

  def self.current_user(session)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end