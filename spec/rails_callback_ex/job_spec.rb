describe 'RailsCallbackEx::Job' do
  before(:each) do 
    SampleJob.__callbacks[:perform].clear
  end

  context 'before callback' do
    it 'inserts before specified callback' do
      SampleJob.before_perform :base1
      SampleJob.before_perform :base2
      SampleJob.insert_before_perform :action, before: :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SampleJob.before_perform :base1
      SampleJob.before_perform :base2
      SampleJob.insert_before_perform :action, after: :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SampleJob.before_perform :base1
      SampleJob.before_perform :base2
      SampleJob.delete_before_perform :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).not_to include(:base1)
    end
  end

  context 'after callback' do
    it 'inserts before specified callback' do
      SampleJob.after_perform :base1
      SampleJob.after_perform :base2
      SampleJob.insert_after_perform :action, before: :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SampleJob.after_perform :base1
      SampleJob.after_perform :base2
      SampleJob.insert_after_perform :action, after: :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SampleJob.after_perform :base1
      SampleJob.after_perform :base2
      SampleJob.delete_after_perform :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).not_to include(:base1)
    end
  end

  context 'around callback' do
    it 'inserts before specified callback' do
      SampleJob.around_perform :base1
      SampleJob.around_perform :base2
      SampleJob.insert_around_perform :action, before: :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SampleJob.around_perform :base1
      SampleJob.around_perform :base2
      SampleJob.insert_around_perform :action, after: :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SampleJob.around_perform :base1
      SampleJob.around_perform :base2
      SampleJob.delete_around_perform :base1
      expect(SampleJob.__callbacks[:perform].map(&:filter)).not_to include(:base1)
    end
  end

  context 'error' do
    it 'raises error when required option is missing' do
      SampleJob.before_perform :base1
      SampleJob.before_perform :base2
      expect { SampleJob.insert_before_perform :action }.to raise_error(ArgumentError)
    end

    it 'raises error when callback of insert position is not found' do
      SampleJob.before_perform :base1
      SampleJob.before_perform :base2
      expect { SampleJob.insert_before_perform :action, before: :unknown }.to raise_error(ArgumentError)
    end

    it 'raises error when callback to delete is not found' do
      expect { SampleJob.delete_before_perform :unknown }.to raise_error(ArgumentError)
    end
  end
end
