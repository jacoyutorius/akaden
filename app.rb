
module Akaden
  class Info
    class << self
      def crawl
        {
          staff: true,
          public_telephone: true,
          version: 2021,
          address: "浜松市中区助信町52-1",
          toilet: true,
          toilet_multipurpose: true,
        }
      end
    end
  end

  class Timetable
  end

  class Fare
  end
end

pp ::Akaden::Info.crawl