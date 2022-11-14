module LoginSupport
  def login(employee)
    visit login_path
    fill_in 'employees[account]', with: employee.account
    fill_in 'employees[password]', with: employee.password
    find('#submit_login').click
  end
end