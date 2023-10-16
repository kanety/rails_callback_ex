describe 'RailsCallbackEx::Controller' do
  before(:each) do 
    SamplesController.__callbacks[:process_action].clear
  end

  context 'before callback' do
    it 'inserts before specified callback' do
      SamplesController.before_action :base1
      SamplesController.before_action :base2
      SamplesController.insert_before_action :action, before: :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SamplesController.before_action :base1
      SamplesController.before_action :base2
      SamplesController.insert_before_action :action, after: :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SamplesController.before_action :base1
      SamplesController.delete_before_action :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).not_to include(:base1)
    end
  end

  context 'after callback' do
    it 'inserts before specified callback' do
      SamplesController.after_action :base1
      SamplesController.after_action :base2
      SamplesController.insert_after_action :action, before: :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SamplesController.after_action :base1
      SamplesController.after_action :base2
      SamplesController.insert_after_action :action, after: :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SamplesController.after_action :base1
      SamplesController.delete_after_action :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).not_to include(:base1)
    end
  end

  context 'around callback' do
    it 'inserts before specified callback' do
      SamplesController.around_action :base1
      SamplesController.around_action :base2
      SamplesController.insert_around_action :action, before: :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).to eq([:action, :base1, :base2])
    end

    it 'inserts after specified callback' do
      SamplesController.around_action :base1
      SamplesController.around_action :base2
      SamplesController.insert_around_action :action, after: :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).to eq([:base1, :action, :base2])
    end

    it 'deletes specified callback' do
      SamplesController.around_action :base1
      SamplesController.delete_around_action :base1
      expect(SamplesController.__callbacks[:process_action].map(&:filter)).not_to include(:base1)
    end
  end

  context 'error' do
    it 'raises error when required option is missing' do
      SamplesController.before_action :base1
      SamplesController.before_action :base2
      expect { SamplesController.insert_before_action :action }.to raise_error(ArgumentError)
    end

    it 'raises error when callback of insert position is not found' do
      SamplesController.before_action :base1
      SamplesController.before_action :base2
      expect { SamplesController.insert_before_action :action, before: :unknown }.to raise_error(ArgumentError)
    end

    it 'raises error when callback to delete is not found' do
      expect { SamplesController.delete_before_action :unknown }.to raise_error(ArgumentError)
    end
  end
end
