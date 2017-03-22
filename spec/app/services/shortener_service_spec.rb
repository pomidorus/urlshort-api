require 'rails_helper'

describe ShortenerService do
  let(:service) { ShortenerService.new(url) }

  describe '#generate' do
    let(:url) { 'http://www.farmdrop.com' }

    it 'creates a new Url record' do
      expect{ service.generate }.to change{ Url.count }.from(0).to(1)
    end

    it 'creates a valid record' do
      service.generate
      expect(Url.last.url).to eq(url)
    end
  end

  context 'url without protocol' do
    let(:url) { 'www.farmdrop.com' }
    let(:url_with_protocol) { 'http://www.farmdrop.com' }

    describe '#new' do
      it 'adds protocol to url' do
        expect(service.url).to eq(url_with_protocol)
      end
    end
  end
end
