require 'spec_helper'

describe Album do

  let(:album) do
    album = Album.new
    album
  end  
  
  it { should be_valid }
end
