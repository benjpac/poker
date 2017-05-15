require 'spec_helper'

describe Hand do
  it { should have_many(:cards) }
end
