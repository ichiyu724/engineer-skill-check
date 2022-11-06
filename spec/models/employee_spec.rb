require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:employee) { create(:employee) }

  describe "社員新規追加" do
    context "メールアドレス入力欄が正常な時" do
      it "メールアドレスが入力できている" do
        expect(employee).to be_valid
      end
    end

    context "メールアドレス入力欄が不正の時" do
      it "emailが空欄だと登録できない" do
        employee.email = ""
        employee.valid?
        expect(employee.errors.full_messages).to include("メールアドレス が入力されていません")
      end
    end
  end
end
