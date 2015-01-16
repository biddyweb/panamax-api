require 'spec_helper'

describe Job do

  it { should belong_to(:job_template) }
  it { should have_many(:steps) }
  it { should respond_to?(:status) }
  it { should respond_to?(:environment) }

end
