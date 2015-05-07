require 'rails_helper'

RSpec.describe "snapshots/new", type: :view do
  before(:each) do
    assign(:snapshot, Snapshot.new(
      :user_id => 1,
      :nwea_math => 1,
      :nwea_reading => 1,
      :math => "MyString",
      :reading => "MyString",
      :science => "MyString",
      :social_studies => "MyString"
    ))
  end

  it "renders new snapshot form" do
    render

    assert_select "form[action=?][method=?]", snapshots_path, "post" do

      assert_select "input#snapshot_user_id[name=?]", "snapshot[user_id]"

      assert_select "input#snapshot_nwea_math[name=?]", "snapshot[nwea_math]"

      assert_select "input#snapshot_nwea_reading[name=?]", "snapshot[nwea_reading]"

      assert_select "input#snapshot_math[name=?]", "snapshot[math]"

      assert_select "input#snapshot_reading[name=?]", "snapshot[reading]"

      assert_select "input#snapshot_science[name=?]", "snapshot[science]"

      assert_select "input#snapshot_social_studies[name=?]", "snapshot[social_studies]"
    end
  end
end
