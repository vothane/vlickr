class Video < ActiveRecord::Base 
  composed_of :video, :class_name => "Asset", :mapping => [ %w(name name), %w(embed_code embed_code), 
                                                            %w(status status), %w(duration duration), 
                                                            %w(duration duration), %w(stream_urls stream_urls)
                                                          ]
end
