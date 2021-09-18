# frozen_string_literal: true

module Akaden
  Station = Struct.new(:code, :name)

  STATIONS = [
    Station.new('shinhamamatsu', '新浜松'),
    Station.new('daiichi-dori', '第一通り'),
    Station.new('enshubyoin', '遠州病院'),
    Station.new('hachiman', '八幡'),
    Station.new('sukenobu', '助信'),
    Station.new('hikuma', '曳馬'),
    Station.new('kamijima', '上島'),
    Station.new('jidosyagakkomae', '自動車学校前'),
    Station.new('saginomiya', 'さぎの宮'),
    Station.new('sekishi', '積志'),
    Station.new('nishigasaki', '西ヶ崎'),
    Station.new('komatsu', '小松'),
    Station.new('hamakita', '浜北'),
    Station.new('misonochuokoen', '美薗中央公園'),
    Station.new('kobayashi', '小林'),
    Station.new('shibamoto', '芝本'),
    Station.new('gansuiji', '岩水寺'),
    Station.new('nishikajima', '西鹿島')
  ].freeze
end
