# frozen_string_literal: true

module Akaden
  describe Info do
    describe '.run' do
      subject { described_class.run(station: station) }

      let(:station) { 'sukenobu' }

      it do
        VCR.use_cassette('info_sukenobu') do
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
        end
      end
    end
  end
end
