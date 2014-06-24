include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end
RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end
RSpec::Matchers.define :have_info_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-info', text: message)
  end
end
