# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'json'

module Akaden
  class Info
    class << self
      def run(station:)
        new(station).run
      end
    end

    def initialize(station)
      @station = station
      @url = "https://www.entetsu.co.jp/tetsudou/station/#{station}.html"
    end

    def run
      {
        name: station_name,
        version: version,
        **station_info,
        **basic_info
      }
    end

    private

    def version
      Time.now.year
    end

    def station_name
      page.css('#stName > h2').text
    end

    def station_info
      body = page.css('#stInfo > div.information > table > tr > td')

      {
        address: body[0]&.text,
        business_hours: body[1]&.text,
        phone: body[2]&.text,
        taxi: body[3]&.text
      }
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def basic_info
      {
        toilet: text_parser(body[0]),
        toilet_multipurpose: text_parser(body[1]),
        staff: text_parser(body[2]),
        wheelchair: text_parser(body[3]),
        elevator: text_parser(body[4]),
        pass: text_parser(body[5]),
        bycicle_parking: text_parser(body[6]),
        monthly_parking: text_parser(body[7]),
        daily_parking: text_parser(body[8]),
        coin_locker: text_parser(body[9]),
        public_telephone: text_parser(body[10]),
        aed: text_parser(body[11])
      }
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    def body
      @body ||= page.css('#stBasic > div.facilities > table > tr > td')
    end

    def text_parser(text)
      return false if text.nil?

      ['○', '有'].include?(text)
    end

    def page
      @page ||= Nokogiri.HTML(URI.parse(@url).open)
    end
  end
end
