describe 'RailsCallbackEx::Record' do
  before(:each) do 
    Sample.__callbacks[:save].clear
  end

  context 'before callback' do
    it 'inserts before specified callback' do
      Sample.before_save :base1
      Sample.before_save :base2
      Sample.insert_before_save :action, before: :base1
      expect(Sample.__callbacks[:save].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      Sample.before_save :base1
      Sample.before_save :base2
      Sample.insert_before_save :action, after: :base1
      expect(Sample.__callbacks[:save].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      Sample.before_save :base1
      Sample.before_save :base2
      Sample.delete_before_save :base1
      expect(Sample.__callbacks[:save].map(&:filter)).not_to include(:base1)
    end
  end

  context 'after callback' do
    it 'inserts before specified callback' do
      Sample.after_save :base1
      Sample.after_save :base2
      Sample.insert_after_save :action, before: :base2
      expect(Sample.__callbacks[:save].map(&:filter)).to eq([:base2, :action, :base1])
    end

    it 'inserts after specified callback' do
      Sample.after_save :base1
      Sample.after_save :base2
      Sample.insert_after_save :action, after: :base2
      expect(Sample.__callbacks[:save].map(&:filter)).to eq([:action, :base2, :base1])
    end

    it 'deletes after specified callback' do
      Sample.after_save :base1
      Sample.after_save :base2
      Sample.delete_after_save :base1
      expect(Sample.__callbacks[:save].map(&:filter)).not_to include(:base1)
    end
  end

  context 'around callback' do
    it 'inserts before specified callback' do
      Sample.around_save :base1
      Sample.around_save :base2
      Sample.insert_around_save :action, before: :base1
      expect(Sample.__callbacks[:save].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      Sample.around_save :base1
      Sample.around_save :base2
      Sample.insert_around_save :action, after: :base1
      expect(Sample.__callbacks[:save].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      Sample.around_save :base1
      Sample.around_save :base2
      Sample.delete_around_save :base1
      expect(Sample.__callbacks[:save].map(&:filter)).not_to include(:base1)
    end
  end

  context 'error' do
    it 'raises error when required option is missing' do
      Sample.before_save :base1
      Sample.before_save :base2
      expect { Sample.insert_before_save :action }.to raise_error(ArgumentError)
    end

    it 'raises error when callback of insert position is not found' do
      Sample.before_save :base1
      Sample.before_save :base2
      expect { Sample.insert_before_save :action, before: :unknown }.to raise_error(ArgumentError)
    end

    it 'raises error when callback to delete is not found' do
      expect { Sample.delete_before_save :unknown }.to raise_error(ArgumentError)
    end
  end
end
