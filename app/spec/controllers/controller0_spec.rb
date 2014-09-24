require 'spec_helper'

# You must either use the controller class to describe the test,
# or defined `@controller` on the setup. So just describe it.
#
# Before RSpec 3, ActionController::TestCase methods like `get`, `request`, etc.
# are magically available on tests just because we are under the `controllers` directory.
# After 3, you must either enable that with an option on you `spec_helper`, or set `type: :controller`.
# http://stackoverflow.com/questions/6296235/undefined-method-get-for-rspeccoreexamplegroupnested-10x00000106db51f
describe Controller0Controller, type: :controller do
  it 'passes' do
    expect(1).to eq(1)
  end

  it 'has ActionController::TestCase methods' do
    get 'rspec'
    assert_response :success
  end

  # RSpec adds Rails controller specific matchers to these tests.
  # https://www.relishapp.com/rspec/rspec-rails/v/3-1/docs/controller-specs
  it 'has RSpec specific controller methods' do
    get 'rspec'
    expect(response).to have_http_status(:success)
  end
end
