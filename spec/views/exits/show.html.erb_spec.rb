require 'spec_helper'

describe "exits/show" do
  before(:each) do
    @exit = assign(:exit, stub_model(Exit,
      :location_id => 1,
      :destination_location_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
