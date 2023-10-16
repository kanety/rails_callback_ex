describe 'RailsCallbackEx::Mailer', if: Rails::VERSION::STRING.to_f >= 7.1 do
  before(:each) do 
    SampleMailer.__callbacks[:deliver].clear
  end

  context 'before callback' do
    it 'inserts before specified callback' do
      SampleMailer.before_deliver :base1
      SampleMailer.before_deliver :base2
      SampleMailer.insert_before_deliver :action, before: :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SampleMailer.before_deliver :base1
      SampleMailer.before_deliver :base2
      SampleMailer.insert_before_deliver :action, after: :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SampleMailer.before_deliver :base1
      SampleMailer.before_deliver :base2
      SampleMailer.delete_before_deliver :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).not_to include(:base1,)
    end
  end

  context 'after callback' do
    it 'inserts before specified callback' do
      SampleMailer.after_deliver :base1
      SampleMailer.after_deliver :base2
      SampleMailer.insert_after_deliver :action, before: :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SampleMailer.after_deliver :base1
      SampleMailer.after_deliver :base2
      SampleMailer.insert_after_deliver :action, after: :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SampleMailer.after_deliver :base1
      SampleMailer.after_deliver :base2
      SampleMailer.delete_after_deliver :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).not_to include(:base1)
    end
  end

  context 'around callback' do
    it 'inserts before specified callback' do
      SampleMailer.around_deliver :base1
      SampleMailer.around_deliver :base2
      SampleMailer.insert_around_deliver :action, before: :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SampleMailer.around_deliver :base1
      SampleMailer.around_deliver :base2
      SampleMailer.insert_around_deliver :action, after: :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SampleMailer.around_deliver :base1
      SampleMailer.around_deliver :base2
      SampleMailer.delete_around_deliver :base1
      expect(SampleMailer.__callbacks[:deliver].map(&:filter)).not_to include(:base1)
    end
  end

  context 'error' do
    it 'raises error when required option is missing' do
      SampleMailer.before_deliver :base1
      SampleMailer.before_deliver :base2
      expect { SampleMailer.insert_before_deliver :action }.to raise_error(ArgumentError)
    end

    it 'raises error when callback of insert position is not found' do
      SampleMailer.before_deliver :base1
      SampleMailer.before_deliver :base2
      expect { SampleMailer.insert_before_deliver :action, before: :unknown }.to raise_error(ArgumentError)
    end

    it 'raises error when callback to delete is not found' do
      expect { SampleMailer.delete_before_deliver :unknown }.to raise_error(ArgumentError)
    end
  end
end
