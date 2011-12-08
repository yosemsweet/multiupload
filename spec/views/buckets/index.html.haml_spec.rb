require 'spec_helper'

describe "buckets/index.html.haml" do
  before(:each) do
    assign(:buckets, [
      stub_model(Bucket,
        :name => "Name"
      ),
      stub_model(Bucket,
        :name => "Name"
      )
    ])
  end

  it "renders a list of buckets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
