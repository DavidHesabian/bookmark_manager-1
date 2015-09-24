  feature 'user add link' do

    background {visit '/'}

    scenario 'add link path works' do
      visit '/add_link'
      expect(page.status_code).to eq 200
    end

    scenario 'user visiting the add link path renders a form' do
      visit '/add_link'
      expect(page).to have_selector "form[action='/new_link']"
      expect(page).to have_selector "form[method='POST']"
      expect(page).to have_selector "input[type='text']"
      expect(page).to have_selector "input[name='title']"
      expect(page).to have_selector "input[name='description']"
      expect(page).to have_selector "input[name='url']"
    end

    scenario 'user can add a link' do
      expect(Link.count).to eq 0
      visit '/add_link'
      fill_in 'title', :with => 'Testpage'
      fill_in 'description', :with => 'Testdescription'
      fill_in 'url', :with => 'www.test.com'
      click_on 'submit'
      expect(Link.count).to eq 1
      expect(page.current_path).to eq '/new_link'
    end
  end