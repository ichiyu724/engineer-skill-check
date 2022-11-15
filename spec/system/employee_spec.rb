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

      scenario "誤った情報では登録できないこと" do
        fill_in 'employee[number]', with: ""
        fill_in 'employee[last_name]', with: ""
        fill_in 'employee[first_name]', with: ""
        fill_in 'employee[account]', with: ""
        fill_in 'employee[password]', with: ""
        fill_in 'employee[email]', with: ""
        fill_in 'employee[date_of_joining]', with: ""
        expect{
          click_button '保存'
        }.to change { Employee.count }.by(0)
        expect(current_path).to eq "/employees"
      end
    end
  end
end

RSpec.describe "社員紹介ページ", type: :system do
  let!(:employee) { create(:employee) }

  describe "社員紹介ページ" do
    context "社員管理権限がある時" do
      before do
        login(employee)
        visit employees_path
      end

      scenario "新規追加、編集、削除ボタンが表示できること" do
        expect(page).to have_link "新規追加"
        expect(page).to have_link "編集"
        expect(page).to have_link "削除"
      end
    end

    context "社員管理権限がない時" do
      before do
        employee2 = FactoryBot.create(:employee, number: "1", account: "foo", employee_info_manage_auth: false)
        login(employee2)
        visit employees_path
      end

      scenario "新規追加、編集、削除ボタンが表示されないこと" do
        expect(page).not_to have_link "新規追加"
        expect(page).not_to have_link "編集"
        expect(page).not_to have_link "削除"
      end
    end
  end
end
