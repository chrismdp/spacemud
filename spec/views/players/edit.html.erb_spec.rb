require 'spec_helper'

describe "players/edit" do
  before(:each) do
    @player = assign(:player, stub_model(Player,
      :name => "MyString",
      :age => 1,
      :location_id => 1
    ))
  end

  it "renders the edit player form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", player_path(@player), "post" do
      assert_select "input#player_name[name=?]", "player[name]"
      assert_select "input#player_age[name=?]", "player[age]"
      assert_select "input#player_location_id[name=?]", "player[location_id]"
    end
  end
end
