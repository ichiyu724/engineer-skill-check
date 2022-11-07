require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article) }

  describe "お知らせ新規投稿" do
    context "新規投稿が成功するとき" do
      it "必須項目が全て入力できている" do
        expect(article).to be_valid
      end
    end
  end
end
