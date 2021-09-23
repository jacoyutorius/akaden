# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'json'

module Akaden
  class Timetable
    class << self
      def run(station:)
        new(station).run
      end
    end

    def initialize(station)
      @station = station
      @url = "https://www.entetsu.co.jp/tetsudou/timetable/#{station}.html"
    end

    def run
      [
        clawling(type: :weekday, detection: :upto),
        clawling(type: :weekday, detection: :downto),
        clawling(type: :weekend, detection: :upto),
        clawling(type: :weekend, detection: :downto)
      ].flatten.compact.map(&:to_hash)
    end

    private

    # @param type[String] :weekday(平日) or :weekend(土日祝)
    # @param detection[String] :upto(上り、新浜松行き) or :downto(下り、西鹿島行き)
    def clawling(type:, detection:)
      TimetableScraper.new(station: @station, type: type, detection: detection)
                      .run(page)
    end

    def page
      @page ||= Nokogiri.HTML(URI.parse(@url).open)
    end
  end
end

pp ::Akaden::Timetable.run(station: 'kamijima') if __FILE__ == $PROGRAM_NAME
