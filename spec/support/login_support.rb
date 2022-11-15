module LoginSupport
  def login(employee)
    visit login_path
    fill_in 'employees[account]', with: employee.account
    fill_in 'employees[password]', with: employee.password
    click_button 'ログイン'
  end
end