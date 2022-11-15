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
  let!(:another_employee) { create(:employee, number: "1", account: "foo", news_post_auth: false) }
  let!(:article) { create(:article, employee_id: employee.id) }
  describe "お知らせ一覧ページ" do
    context "お知らせ投稿権限がある時" do
      before do
        login(employee)
        visit articles_path
      end

      scenario "新規追加、編集、削除ボタンが表示できること" do
        expect(page).to have_link "新規追加"
        expect(page).to have_link "編集"
        expect(page).to have_link "削除"
      end
    end

    context "お知らせ投稿権限がない時" do
      before do
        login(another_employee)
        visit articles_path
      end

      scenario "新規追加、編集、削除ボタンが表示されないこと" do
        expect(page).not_to have_link "新規追加"
        expect(page).not_to have_link "編集"
        expect(page).not_to have_link "削除"
      end
    end

    context "自分の投稿を編集、削除できることの検証" do
      before do
        login(employee)
        visit articles_path
      end

      scenario "自分の投稿は編集できること" do
        click_on "編集"
        expect(current_path).to eq edit_article_path(article)
      end

      scenario "自分の投稿は削除できること" do
        expect{
          click_on '削除'
        }.to change { Article.count }.by(-1)
        expect(current_path).to eq articles_path
      end
    end

    context "他者の投稿を編集、削除できないことの検証" do
      before do
        employee2 = FactoryBot.create(:employee, number: "2", account: "bar")
        login(employee2)
        visit articles_path
      end

      scenario "他者の投稿は編集できないこと" do
        click_on "編集"
        expect(current_path).to eq "/articles"
        expect(page).to have_content "権限がありません"
      end

      scenario "他者の投稿は削除できないこと" do
        expect{
          click_on '削除'
        }.to change { Article.count }.by(0)
        expect(current_path).to eq "/articles"
        expect(page).to have_content "権限がありません"
      end
    end
  end
end

RSpec.describe "お知らせ参照", type: :system do
  let!(:employee) { create(:employee) }
  let!(:another_employee) { create(:employee, number: "1", account: "foo", news_post_auth: false) }
  let!(:article) { create(:article, employee_id: employee.id) }
  describe "お知らせ参照ページ" do
    before do
      login(employee)
      visit article_path(article)
    end

    scenario "お知らせ参照ページが表示できること" do
      expect(page).to have_content article.title
      expect(page).to have_content article.content
    end
  end
end
