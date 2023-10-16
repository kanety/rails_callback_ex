describe 'RailsCallbackEx::Model' do
  before(:each) do 
    SampleModel.__callbacks[:validation].clear
  end

  context 'before callback' do
    it 'inserts before specified callback' do
      SampleModel.before_validation :base1
      SampleModel.before_validation :base2
      SampleModel.insert_before_validation :action, before: :base1
      expect(SampleModel.__callbacks[:validation].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SampleModel.before_validation :base1
      SampleModel.before_validation :base2
      SampleModel.insert_before_validation :action, after: :base1
      expect(SampleModel.__callbacks[:validation].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SampleModel.before_validation :base1
      SampleModel.before_validation :base2
      SampleModel.delete_before_validation :base1
      expect(SampleModel.__callbacks[:validation].map(&:filter)).not_to include(:base1)
    end
  end

  context 'after callback' do
    it 'inserts before specified callback' do
      SampleModel.after_validation :base1
      SampleModel.after_validation :base2
      SampleModel.insert_after_validation :action, before: :base2
      expect(SampleModel.__callbacks[:validation].map(&:filter)).to eq([:base2, :action, :base1])
    end

    it 'inserts after specified callback' do
      SampleModel.after_validation :base1
      SampleModel.after_validation :base2
      SampleModel.insert_after_validation :action, after: :base2
      expect(SampleModel.__callbacks[:validation].map(&:filter)).to eq([:action, :base2, :base1])
    end

    it 'deletes specified callback' do
      SampleModel.after_validation :base1
      SampleModel.after_validation :base2
      SampleModel.delete_after_validation :base1
      expect(SampleModel.__callbacks[:validation].map(&:filter)).not_to include(:base1)
    end
  end

  context 'error' do
    it 'raises error when required option is missing' do
      SampleModel.before_validation :base1
      SampleModel.before_validation :base2
      expect { SampleModel.insert_before_validation :action }.to raise_error(ArgumentError)
    end

    it 'raises error when callback of insert position is not found' do
      SampleModel.before_validation :base1
      SampleModel.before_validation :base2
      expect { SampleModel.insert_before_validation :action, before: :unknown }.to raise_error(ArgumentError)
    end

    it 'raises error when callback to delete is not found' do
      expect { SampleModel.delete_before_validation :unknown }.to raise_error(ArgumentError)
    end
  end
end
