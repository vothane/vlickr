require "spec_helper"

describe Video do

  module OOYALA
    def self.expires(expiration_window = 25)
      1577898300
    end
  end  

  http_data = objectize_yaml('query_by_description')        
  ActiveResource::HttpMock.respond_to { |mock| mock.get "/v2/assets?api_key=JkN2w61tDmKgPl4y395Rp1vAdlcq.IqBgb&expires=1577898300&signature=qIJSWnyLjbS6zDEvfzlWDRwRIfpd2DKgNG2nRuoco4U&where=description%3D%27Iron+Man%2C+Thor%2C+Captain+America%2C+and+the+Hulk%27", {"Accept"=>"application/json"}, http_data.response_body }
     
  results = Asset.find(:all) do |vid|
    vid.description == "Iron Man, Thor, Captain America, and the Hulk"
  end

  asset_video = results.first

  let(:video) do
    video = Video.new
    video.asset = asset_video
    video
  end  

  let(:bad_video) do
    video = Video.new
    video
  end  

  subject { video }

  it { should respond_to(:name) }
  it { should respond_to(:embed_code) }
  it { should respond_to(:description) }
  it { should respond_to(:embed_code) }
  it { should respond_to(:duration) }
  it { should respond_to(:status) }

  it { should be_valid }

  context "when calling delegate methods on a video model instance" do

    it "should call asset destroy method in before_destroy callback" do

      video.name.should == "Avengers"
      video.embed_code  == "o1NmdxMzrrWwbOVk_wIqhw-AmhlOMO49" 
      video.description == "Nick Fury, the director of S.H.I.E.L.D., assembles a group of superheroes that includes Iron Man, Thor, Captain America, and the Hulk to fight a new enemy that is threatening the safety of the world."
      video.duration    == 143477
      video.status      == "live"
      video.preview_image_url == "http://ak.c.ooyala.com/o1NmdxMzrrWwbOVk_wIqhw-AmhlOMO49/j14TFkN_kLvndon35hMDoxOmFkO7UOTK"

    end

  end   

  context "when destroying video instance" do

    it "should call asset destroy method in before_destroy callback" do
      bad_video.save
    end

  end  

  context "when destroying video instance" do

    it "should call asset destroy method in before_destroy callback" do
      asset_video.should_receive( :destroy )

      video.destroy
    end

  end  

  context "when using scope querys" do

    it "should find recent videos" do
      Video.recent.count.should == 4
    end

  end  

end
