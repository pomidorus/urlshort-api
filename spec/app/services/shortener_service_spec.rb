require 'rails_helper'

describe ShortenerService do
  let(:service) { ShortenerService.new(url) }

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
