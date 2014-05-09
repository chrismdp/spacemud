require 'spec_helper'

describe "exits/edit" do
  before(:each) do
    @exit = assign(:exit, stub_model(Exit,
      :location_id => 1,
      :destination_location_id => 1
    ))
  end

  it "renders the edit exit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", exit_path(@exit), "post" do
      assert_select "input#exit_location_id[name=?]", "exit[location_id]"
      assert_select "input#exit_destination_location_id[name=?]", "exit[destination_location_id]"
    end
  end
end
