# frozen_string_literal: true

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

require 'akaden'

::Akaden::STATIONS.each do |station|
  pp ::Akaden::Info.run(station: station.code)
end
