# frozen_string_literal: true

describe ::Akaden::Fare do
  describe '.run' do
    subject { described_class.run(station: station).first }

    ::Akaden::STATIONS.each do |station|
      context station.name do
        let(:station) { station.code }

        it `return stations info` do
          VCR.use_cassette("fare_#{station.code}") do
            expect(subject).to include :to
            expect(subject).to include :fare_adult
            expect(subject).to include :fare_child
            expect(subject).to include :required
            expect(subject).to include :version
          end
        end
      end
    end
  end
end
