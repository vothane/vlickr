# Vlickr

## Simple Thumbnail viewer of videos in OOYALA Account Using Sinatra and BackBoneJS

To install Sinatra and all of the other gems necessary to run Vlickr, install the 
bundler gem, then use bundler to install the remaining gems:

```
gem install bundler

bundle install
```

Then run `ruby app.rb` from a command prompt. This will start the sinatra web server. 
Open your browser to http://localhost:4567 and enjoy.

The incomplete gem **acts_as_voodoo** is still being maintain, development has been frozen until ActiveResource version 4 is released. This is because the ooyala api has some http *patch* calls that is **not** provided by earlier versions of AR.
