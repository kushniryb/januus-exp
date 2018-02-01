require 'rails_helper'

describe ApplicationHelper do
  let(:controller_params) do
    {
      context:         self,
      controller_name: controller_name,
      action_name:     action_name
    }
  end

  describe '#include_action_javascript' do
    let(:params) { build(:asset_settings, :default, controller_params) }

    before do
      expect(ActionSpecificAssets::Loader).to receive(:call)
                                                .with(params)
                                                .and_return(:loaded)
    end

    it { include_action_javascript }
  end

  describe '#include_action_stylesheet' do
    let(:params) { build(:asset_settings, :default_stylesheet, controller_params) }

    before do
      expect(ActionSpecificAssets::Loader).to receive(:call)
                                                .with(params)
                                                .and_return(:loaded)
    end

    it { include_action_stylesheet }
  end

  describe '#page_title' do
    before { allow(self).to receive(:t).and_return('') }

    context 'with locale' do
      before do
        expect_any_instance_of(String).to receive(:blank?).and_return(false)

        expect(self).to receive(:t)
                          .with('app_action', action_name: '')
                          .and_return(:title)
      end

      it { expect(page_title).to eq(:title) }
    end

    context 'without locale' do
      before { expect(self).to receive(:t).with('app_name').and_return(:default_title) }

      it { expect(page_title).to eq(:default_title) }
    end
  end
end
