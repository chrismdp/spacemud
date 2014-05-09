require 'spec_helper'

describe "exits/index" do
  before(:each) do
    assign(:exits, [
      stub_model(Exit,
        :location_id => 1,
        :destination_location_id => 2
      ),
      stub_model(Exit,
        :location_id => 1,
        :destination_location_id => 2
      )
    ])
  end

  it "renders a list of exits" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
