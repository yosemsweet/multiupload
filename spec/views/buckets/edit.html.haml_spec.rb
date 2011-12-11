require 'spec_helper'

describe "buckets/edit.html.haml" do
  before(:each) do
    @bucket = assign(:bucket, stub_model(Bucket,
      :name => "MyString"
    ))
  end

  it "renders the edit bucket form" do
    render

    assert_select "form", :action => buckets_path(@bucket), :method => "post" do
      assert_select "input#bucket_name", :name => "bucket[name]"
    end
  end

	it "renders a dropbox area" do
		render
		
		assert_select ".dropbox"
	end
end
