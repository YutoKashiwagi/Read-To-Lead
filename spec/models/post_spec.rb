# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post) }

  it '有効なファクトリを持つこと' do
    expect(FactoryBot.create(:post)).to be_valid
  end

  context 'バリデーション' do
    it 'presence' do
      post.picture = nil
      post.valid?
      expect(post.errors[:picture]).to include("can't be blank")
    end
    
    it 'length:title' do
      post.title = 'a' * 21
      post.valid?
      expect(post.errors[:title]).to include("is too long (maximum is 20 characters)")
    end

    it '画像の形式' do
      post.picture = 'hogehogefoobar.gif'
      post.valid?
      expect(post.errors[:picture]).to include("can't be blank")
    end
  end
end
