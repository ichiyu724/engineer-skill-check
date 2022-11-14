require 'rails_helper'

RSpec.describe "社員新規登録", type: :system do
  let!(:employee) { create(:employee) }
  describe "社員登録ページ" do
    context "社員新規登録ができるとき" do
      before do
        login(employee)
        visit new_employee_path
      end

      scenario "正しい情報を入力すれば社員登録ができて社員一覧に移動する" do
        fill_in 'employee[number]', with: "2"
        fill_in 'employee[last_name]', with: "渡辺"
        fill_in 'employee[first_name]', with: "太郎"
        fill_in 'employee[account]', with: "watanabe"
        fill_in 'employee[password]', with: "hoge"
        fill_in 'employee[email]', with: "watanabe@example.co.jp"
        fill_in 'employee[date_of_joining]', with: Date.parse("2022-11-01")
        select '総務部', from: 'employee[department_id]'
        select '東京', from: 'employee[office_id]' 
        check 'employee[employee_info_manage_auth]'
        check 'employee[news_post_auth]'
        expect{
          click_button '保存'
        }.to change { Employee.count }.by(1)
        expect(current_path).to eq employees_path
        expect(page).to have_content "社員「渡辺 太郎」を登録しました。"
      end
    end
  end
end
