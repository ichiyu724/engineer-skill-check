require 'rails_helper'

RSpec.describe "お知らせ新規投稿", type: :system do
  let!(:employee) { create(:employee) }
  let!(:article) { create(:article, employee_id: employee.id) }
  describe "お知らせ投稿ページ" do
    context "お知らせ投稿ができるとき" do
      before do
        login(employee)
        visit new_article_path
      end

      scenario "正しい情報を入力すればお知らせ投稿ができてお知らせ一覧に移動する" do
        fill_in 'article[title]', with: "new_post"
        fill_in 'article[content]', with: "新しい投稿です"
        expect{
          click_button '保存'
        }.to change { Article.count }.by(1)
        expect(current_path).to eq articles_path
        expect(page).to have_content "お知らせを投稿しました"
      end

      scenario "誤った情報では登録できないこと" do
        fill_in 'article[title]', with: ""
        fill_in 'article[content]', with: ""
        expect{
          click_button '保存'
        }.to change { Article.count }.by(0)
        expect(current_path).to eq "/articles"
      end
    end
  end
end

RSpec.describe "お知らせ一覧", type: :system do
  let!(:employee) { create(:employee) }
  let!(:another_employee) { create(:employee, number: "2", account: "foo", news_post_auth: false) }
  let!(:article) { create(:article, employee_id: employee.id) }
  describe "お知らせ一覧ページ" do
    context "お知らせ投稿権限がある時" do
      before do
        login(employee)
        visit articles_path
      end

      scenario "編集、削除ボタンが表示できること" do
        expect(page).to have_link "編集"
        expect(page).to have_link "削除"
      end
    end
  end
end
