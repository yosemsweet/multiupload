require 'spec_helper'

describe "buckets/show.html.haml" do
  before(:each) do
    @bucket = assign(:bucket, stub_model(Bucket,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
