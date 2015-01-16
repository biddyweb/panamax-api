require 'spec_helper'

describe JobTemplate do
  it { should have_many(:steps) }
  it { should respond_to?(:cluster_job_templates) }
  it { should respond_to?(:environment) }

  let(:step_a) { JobTemplateStep.create(order: 1) }
  let(:step_b) { JobTemplateStep.create(order: 2) }

  describe '#steps' do
    let(:steps) { [step_b, step_a] } # out of order
    subject { described_class.create(steps: steps) }

    it 'returns job steps in order' do
      subject.reload
      expect(subject.steps).to match_array([step_b, step_a])
      expect(subject.steps.first).to eq step_a
      expect(subject.steps.second).to eq step_b
    end
  end

  describe '.load_templates' do
    let(:child) { double(:child, read: '') }
    let(:pathname) { double(:pathname) }

    before do
      allow(pathname).to receive(:each_child).and_yield(child)
    end

    it 'invokes the JobTemplateBuilder' do
      expect(JobTemplateBuilder).to receive(:create).once
      described_class.load_templates(pathname)
    end

  end

end
