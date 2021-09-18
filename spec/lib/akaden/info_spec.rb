# frozen_string_literal: true

describe ::Akaden::Info do
  describe '.run' do
    subject { described_class.run(station: station) }

    ::Akaden::STATIONS.each do |station|
      context station.name do
        let(:station) { station.code }

        it `return stations info` do
          VCR.use_cassette("info_#{station.code}") do
            expect(subject).to include :name
            expect(subject).to include :staff
            expect(subject).to include :public_telephone
            expect(subject).to include :version
            expect(subject).to include :address
            expect(subject).to include :toilet
            expect(subject).to include :toilet_multipurpose
            expect(subject).to include :elevator
            expect(subject).to include :pass
            expect(subject).to include :daily_parking
            expect(subject).to include :bycicle_parking
            expect(subject).to include :coin_locker
            expect(subject).to include :business_hours
            expect(subject).to include :taxi
            expect(subject).to include :wheelchair
            expect(subject).to include :monthly_parking
            expect(subject).to include :phone
            expect(subject).to include :aed
            expect(subject[:name]).to eq station.name
          end
        end
      end
    end
  end
end
