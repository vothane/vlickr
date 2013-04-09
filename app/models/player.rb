require 'active_resource'
require 'concerns/acts_as_voodoo'

class Player < ActiveResource::Base
  DEFAULT_PLAYER = "Default player"

  my_api_key    = 'JkN2w61tDmKgPl4y395Rp1vAdlcq.IqBgb'
  my_api_secret = 'nU2WjeYoEY0MJKtK1DRpp1c6hNRoHgwpNG76dJkX'

  acts_as_voodoo :api_key => my_api_key, :api_secret => my_api_secret

  self.site = "https://api.ooyala.com/v2"

  def player_code
    return id
  end  

  def self.default_player
    players = Player.find(:all)
    players.each do |player|
      if player.name == DEFAULT_PLAYER
        return player
      end
    end
  end  
end