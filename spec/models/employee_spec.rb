require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe "社員新規追加" do
    context "メールアドレス入力欄が正常な時" do
      it "メールアドレスが入力できている" do
        expect(employee).to be_valid
      end
    end
  end
end
