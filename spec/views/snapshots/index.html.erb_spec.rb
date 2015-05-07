require 'rails_helper'

RSpec.describe "snapshots/index", type: :view do
  before(:each) do
    assign(:snapshots, [
      Snapshot.create!(
        :user_id => 1,
        :nwea_math => 2,
        :nwea_reading => 3,
        :math => "Math",
        :reading => "Reading",
        :science => "Science",
        :social_studies => "Social Studies"
      ),
      Snapshot.create!(
        :user_id => 1,
        :nwea_math => 2,
        :nwea_reading => 3,
        :math => "Math",
        :reading => "Reading",
        :science => "Science",
        :social_studies => "Social Studies"
      )
    ])
  end

  it "renders a list of snapshots" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Math".to_s, :count => 2
    assert_select "tr>td", :text => "Reading".to_s, :count => 2
    assert_select "tr>td", :text => "Science".to_s, :count => 2
    assert_select "tr>td", :text => "Social Studies".to_s, :count => 2
  end
end
