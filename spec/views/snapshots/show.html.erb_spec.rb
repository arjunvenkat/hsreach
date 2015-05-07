require 'rails_helper'

RSpec.describe "snapshots/show", type: :view do
  before(:each) do
    @snapshot = assign(:snapshot, Snapshot.create!(
      :user_id => 1,
      :nwea_math => 2,
      :nwea_reading => 3,
      :math => "Math",
      :reading => "Reading",
      :science => "Science",
      :social_studies => "Social Studies"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Math/)
    expect(rendered).to match(/Reading/)
    expect(rendered).to match(/Science/)
    expect(rendered).to match(/Social Studies/)
  end
end
