[![Code Climate](https://codeclimate.com/github/vothane/vlickr.png)](https://codeclimate.com/github/vothane/vlickr)

Social Video Sharing Rails 4 App that uses acts_as_voodoo to handle the OOYALA api as first class objects (create, read, update, delete and store videos).

# Ruby on Rails App that implements acts_as_voodoo: sample application

Tests

    $ git clone https://github.com/vothane/vlickr.git
    $ cd vlickr
    $ bundle install
    $ bundle exec rake db:migrate
    $ bundle exec rake db:test:prepare
    $ bundle exec rspec spec/

Run app

    $ rails s Puma

