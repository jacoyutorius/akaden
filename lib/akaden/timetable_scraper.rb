# frozen_string_literal: true

module Akaden
  class TimetableScraper
    def initialize(station:, type:, detection:)
      @station = station
      @type = type
      @detection = detection
    end

    def run(page)
      page.xpath(row_xpath).map do |row|
        run_hour(row)
      end.flatten.compact
    end

    private

    # TODO: メソッド名変えたい
    # @return Array
    # rubocop:disable Metrics/MethodLength
    def run_hour(row)
      hour = row.xpath('td[2]').text

      row.xpath(detection_xpath).map do |col|
        return nil if col.text == ''

        {
          station: @station,
          detection: @detection,
          type: @type,
          time: "#{hour}:#{col.text}",
          formation: parse_formation(col),
          version: version
        }
      end
    end
    # rubocop:enable Metrics/MethodLength

    def parse_formation(col)
      case col.attributes['class']&.value
      when 'week', 'weekend' then 4
      else 2
      end
    end

    def row_xpath
      "//*[@id='tTable']/#{type_xpath}/tbody/tr"
    end

    def type_xpath
      case @type
      when :weekday then 'table[1]'
      when :weekend then 'table[2]'
      end
    end

    def detection_xpath
      case @detection
      when :upto then 'td[1]/span'
      when :downto then 'td[3]/span'
      end
    end

    def version
      Time.now.year
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  require 'open-uri'
  require 'nokogiri'

  url = 'https://www.entetsu.co.jp/tetsudou/timetable/kamijima.html'
  page = Nokogiri.HTML(URI.parse(url).open)
  pp ::Akaden::TimetableScraper.new(station: 'kamijima', type: :weekday, detection: :upto)
                               .run(page)
end
