# frozen_string_literal: true

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

require 'akaden'

# pp ::Akaden::Info.run(station: 'kamijima')

::Akaden::STATIONS.each do |station|
  pp ::Akaden::Info.run(station: station)
end
