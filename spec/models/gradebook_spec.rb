require 'spec_helper'

describe Gradebook do
  before(:all) do
  	@user = FactoryGirl.create(:user)
  	@gradebook = @user.gradebook
  end
  subject { @gradebook }

	it { should belong_to :user }

end