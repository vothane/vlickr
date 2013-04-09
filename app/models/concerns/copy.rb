module Copy
  def copy
    self.class.new.tap do |object|
      attributes.each do |key, value|
        object.send("#{key}=", value) unless key=="id"
      end
      object.save
    end
  end
end  