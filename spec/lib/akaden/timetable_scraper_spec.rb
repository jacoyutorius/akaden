# frozen_string_literal: true

describe ::Akaden::TimetableScraper do
  describe '.run' do
    shared_context :valid_timetable? do
      it do
        record = subject.first
        expect(record).to include :station
        expect(record).to include :detection
        expect(record).to include :type
        expect(record).to include :time
        expect(record).to include :formation
        expect(record).to include :version
      end
    end

    shared_context :valid_station_timetable? do |station, upto, downto|
      let(:station) { station }
      let(:url) { "https://www.entetsu.co.jp/tetsudou/timetable/#{station}.html" }

      if upto
        context 'weekday / upto' do
          let(:type) { :weekday }
          let(:detection) { :upto }

          include_context :valid_timetable?
        end

        context 'weekend / upto' do
          let(:type) { :weekend }
          let(:detection) { :upto }

          include_context :valid_timetable?
        end
      end

      if downto
        context 'weekday / downto' do
          let(:type) { :weekday }
          let(:detection) { :downto }

          include_context :valid_timetable?
        end

        context 'weekend / downto' do
          let(:type) { :weekend }
          let(:detection) { :downto }

          include_context :valid_timetable?
        end
      end
    end

    subject do
      VCR.use_cassette("timetable_#{station}_#{type}_#{detection}") do
        page = Nokogiri.HTML(URI.parse(url).open)
        described_class.new(station: station, type: type, detection: detection)
                       .run(page)
      end
    end

    ::Akaden::STATIONS.each do |station|
      context station.name do
        case station.code
        when 'shinhamamatsu' then include_context :valid_station_timetable?, station.code, false, true
        when 'nishikajima' then include_context :valid_station_timetable?, station.code, true, false
        else
          include_context :valid_station_timetable?, station.code, true, true
        end
      end
    end
  end
end
