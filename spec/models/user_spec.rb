require 'rails_helper'
describe User do
  describe '#create' do
    it "is valid normal input" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "is invalid either password or password_confirmation" do
      user = build(:user, password_confirmation: "11111111")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "is invalid more than 7 charactors of nickname" do
      user = build(:user, nickname: "1234567")
      user.valid?
      # binding.pry
      expect(user.errors[:nickname][0]).to include("is too long")
      # expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

    it "is valid less than 6 charactors of nickname" do
      user = build(:user, nickname: "123456")
      expect(user).to be_valid
    end

    it "is invalid same email exsists" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    it "is valid more than 6 charactors of password" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      expect(user).to be_valid
    end

    it "is invalid less than 5 charactors of password" do
      user = build(:user, password: "12345")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
      # expect(user.errors[:password]).to include("is too short")
    end

    # it "is invalid" do
    #   user = build(:user, nickname: "1234567", email: "", password: "1234", password_confirmation: "5678")
    #   user.valid?
    #   # binding.pry
    #   expect(user.errors[:email][0]).to include("can't")
    # end
  end
end