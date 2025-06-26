module Settings
  class ApiKeysController < ApplicationController
    before_action :authenticate_user!
    
    def show
    end
  end
end
