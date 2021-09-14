# frozen_string_literal: true

module Akaden
  class Info
    class << self
      def crawl(station:)
        new(station).run
      end
    end

    def initialize(station)
      @station = station
    end

    def run
      {
        staff: true,
        public_telephone: true,
        version: 2021,
        address: '浜松市中区助信町52-1',
        toilet: true,
        toilet_multipurpose: true
      }
    end
  end
end
