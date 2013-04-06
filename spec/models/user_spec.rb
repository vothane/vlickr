require "spec_helper"

describe User do

  let(:user) do
    User.new(name: "John Ghey", email: "John.Ghey@asylum.com", user_name: "The_Fraud")
  end

  subject { user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:user_name) }

  it { should be_valid }


  context "callbacks" do
    describe "#save_user!" do
      it "downcases email" do
        user.email.should_receive( :downcase! )
        user.email = "John.Ghey@NutHouse.com"
        user.save
        user.email.should == "john.ghey@nuthouse.com"
      end
    end
  end

  context "when email" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end      
    end

    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end      
    end
  end
end
