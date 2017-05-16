require 'spec_helper'

describe Card do
  it { should belong_to(:round) }
  it { should belong_to(:hand) }
  it { should belong_to(:deck) }

end
