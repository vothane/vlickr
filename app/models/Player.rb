$:.unshift(File.join(File.dirname(__FILE__), ".", "acts_as_voodoo"))
require 'acts_as_voodoo'

class Player < ActiveResource::Base
   my_api_key    = 'JkN2w61tDmKgPl4y395Rp1vAdlcq.IqBgb'
   my_api_secret = 'nU2WjeYoEY0MJKtK1DRpp1c6hNRoHgwpNG76dJkX'

   acts_as_voodoo :api_key => my_api_key, :api_secret => my_api_secret

   self.site = "https://api.ooyala.com/v2"
end