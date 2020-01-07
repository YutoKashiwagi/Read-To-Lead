# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "ユーザーが正常に作成されること" do
    @user = User.new(name:'foobar',email:'foobar@example.com',password:"foobar")
    expect(@user.valid?).to eq true
  end
end
