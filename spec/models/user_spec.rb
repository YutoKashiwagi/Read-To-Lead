# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }
  it '有効なファクトリを持つこと' do
    expect(user.valid?).to eq true
  end

  describe 'バリデーションのテスト' do
    context 'name' do
      it 'presence' do
        user.name = ''
        user.valid?
        expect(user.errors[:name]).to include("can't be blank")
      end

      it 'length' do
        user.name = 'a' * 100
        user.valid?
        expect(user.errors[:name]).to include('is too long (maximum is 30 characters)')
      end
    end
    
    context 'profile' do
      it 'length' do
        user.profile = 'a' * 201
        user.valid?
        expect(user.errors[:profile]).to include("is too long (maximum is 200 characters)")
      end
    end

    context 'password' do
      it 'presence' do
        user.password = ''
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'length' do
        user.password = 'a' * 100
        user.valid?
        expect(user.errors[:password]).to include('is too long (maximum is 30 characters)')
      end
    end

    context 'email' do
      it 'presence' do
        user.email = ''
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'length' do
        user.email = 'a' * 256
        user.valid?
        expect(user.errors[:email]).to include('is too long (maximum is 255 characters)')
      end

      it 'uniqueness' do
        unique_user = FactoryBot.create(:user, email: 'unique@unique.com')
        dup_user =    FactoryBot.build(:user, email: 'unique@unique.com')
        dup_user.valid?
        expect(dup_user.errors[:email]).to include('has already been taken')
      end
    end
  end
end
