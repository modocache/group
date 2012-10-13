require 'spec_helper'


describe 'has_uuid' do
  with_model :BlogPost do
    table do |t|
      t.string :uuid
    end

    model do
      include HasUuid
    end
  end

  it 'should set the UUID on creation' do
    post = BlogPost.new
    post.uuid.should be_nil
    post.save
    post.uuid.should be
  end

  it 'should not set the UIUD if it already exists' do
    post = BlogPost.new
    post.uuid = 'good-burgers'
    post.save
    post.uuid.should == 'good-burgers'
  end

  it 'should validate presence of UUID' do
    post = BlogPost.create
    post.should validate_presence_of :uuid
  end
  it 'should validate uniqueness of UUID' do
    post = BlogPost.new
    another_post = BlogPost.create
    post.should validate_uniqueness_of :uuid
  end

end
