require 'rails_helper'

describe ActionSpecificAssets::Loader do
  let(:context)         { double }
  let(:params)          { build(:asset_settings) }
  let(:controller_name) { params[:controller_name] }
  let(:action_name)     { params[:action_name] }
  let(:asset_type)      { params[:asset_type] }
  let(:optional)        { params[:optional] }
  let(:path)            { "#{controller_name}/#{action_name}" }

  subject { described_class.call(params.merge(context: context)) }

  before do
    allow_any_instance_of(described_class).to receive(:context).and_return(context)
  end

  context 'valid' do
    context 'loading javascript' do
      before do
        expect(context).to receive(:javascript_include_tag)
                             .with(path, optional)
                             .and_return(:loaded)
      end

      it { expect(subject).to eq(:loaded) }
    end

    context 'loading stylesheet' do
      let(:params) { build(:asset_settings, :stylesheet) }

      before do
        expect(context).to receive(:stylesheet_link_tag)
                             .with(path, optional)
                             .and_return(:loaded)
      end

      it { expect(subject).to eq(:loaded) }
    end
  end

  context 'invalid' do
    before do
      expect(context).to receive(:javascript_include_tag)
                          .with(path, optional)
                          .and_raise(Sprockets::Rails::Helper::AssetNotFound)
    end

    context 'with silence mode on' do
      let(:params) { build(:asset_settings, silence: true) }

      before { expect(context).not_to receive(:javascript_tag) }

      it { subject }
    end

    context 'with silence mode off' do
      let(:params)  { build(:asset_settings, silence: false) }
      let(:message) { "#{asset_type.to_s.capitalize} for '#{path}' wasn't loaded!" }
      let(:script)  { "console.log(\"#{message}\")" }

      before do
        expect(context).to receive(:javascript_tag).with(script).and_return(:message)
      end

      it { expect(subject).to eq(:message) }
    end
  end
end
