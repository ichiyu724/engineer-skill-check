require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { create(:employee) }

  describe "社員新規追加" do
    context "新規登録が成功するとき" do
      it "必須項目が全て入力できている" do
        expect(employee).to be_valid
      end
    end

    context "新規登録が失敗するとき" do
      it "emailが空欄だと登録できない" do
        employee.email = ""
        employee.valid?
        expect(employee.errors.full_messages).to include("メールアドレス が入力されていません")
      end

      it "入社年月日が空欄だと登録できない" do
        employee.date_of_joining = ""
        employee.valid?
        expect(employee.errors.full_messages).to include("入社年月日 が入力されていません")
      end

      it "社員番号が空欄だと登録できない" do
        employee.number = ""
        employee.valid?
        expect(employee.errors.full_messages).to include("社員番号 が入力されていません")
      end

      it "氏名（姓）が空欄だと登録できない" do
        employee.last_name = ""
        employee.valid?
        expect(employee.errors.full_messages).to include("氏名（姓） が入力されていません")
      end
    end
  end
end
