require 'spec_helper'

describe "exits/new" do
  before(:each) do
    assign(:exit, stub_model(Exit,
      :location_id => 1,
      :destination_location_id => 1
    ).as_new_record)
  end

  it "renders new exit form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", exits_path, "post" do
      assert_select "input#exit_location_id[name=?]", "exit[location_id]"
      assert_select "input#exit_destination_location_id[name=?]", "exit[destination_location_id]"
    end
  end
end
