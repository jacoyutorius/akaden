module Akaden
  describe Info do
    describe '.crawl' do
      subject { described_class.crawl }

      it do
        expect(subject).to include :staff
        expect(subject).to include :public_telephone
        expect(subject).to include :version
        expect(subject).to include :address
        expect(subject).to include :toilet
        expect(subject).to include :toilet_multipurpose
      end
    end
  end
end