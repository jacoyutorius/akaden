# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'json'

module Akaden
  class Fare
    class << self
      def run(station:)
        new(station).run
      end
    end

    def initialize(station)
      @station = station
      @url = "https://www.entetsu.co.jp/tetsudou/fare/#{station}.html"
    end

    def run
      fare
    end

    private

    def version
      Time.now.year
    end

    def fare
      page.css('#fareBox > div.fareTbl > table > tbody > tr').map do |tr|
        doc = tr.css('td')

        {
          to: doc[0].children.attribute('class').value,
          fare_adult: doc[1].text,
          fare_child: doc[2].text,
          required: doc[3].text,
          version: version
        }
      end
    end

    def page
      @page ||= Nokogiri.HTML(URI.parse(@url).open)
    end
  end
end

pp ::Akaden::Fare.run(station: 'kamijima') if __FILE__ == $PROGRAM_NAME
