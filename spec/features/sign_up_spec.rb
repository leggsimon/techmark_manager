feature 'User Sign-up' do

  let(:user) do
    build :user
  end

  scenario 'can sign-up as new user' do
    expect { sign_up user }.to change(User, :count).by(1)
    expect(page).to have_content("#{user.username}")
    expect(User.first.email).to eq 'banana@example.com'
  end

  scenario ' I cannot sign up with an existing email' do
    sign_up user
    expect { sign_up user }.to change(User, :count).by(0)
    expect(page).to have_content 'Email is already taken'
  end

  scenario 'with a password that does not match' do
    expect { sign_up(build :user, password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq '/user'
    expect(page).to have_content 'Password does not match the confirmation'
  end

end
