require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create(:article) }

  describe "お知らせ新規投稿" do
    context "新規投稿が成功するとき" do
      it "必須項目が全て入力できている" do
        expect(article).to be_valid
      end
    end

    context "新規投稿が失敗するとき" do
      it "タイトルが空欄だと登録できない" do
        article.title = ""
        article.valid?
        expect(article.errors.full_messages).to include("タイトル が入力されていません")
      end

      it "タイトルが50文字以上だと投稿できない"  do
        article.title = "アイウエオかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわおん0123456789"
        article.valid?
        expect(article.errors.full_messages).to include("タイトル は50文字以内で入力してください")
      end
      it "お知らせ内容が空欄だと登録できない" do
        article.content = ""
        article.valid?
        expect(article.errors.full_messages).to include("内容 が入力されていません")
      end
    end
  end
end
