$LOAD_PATH.unshift(File.dirname(__FILE__) + "/lib")

require 'akaden'

pp ::Akaden::Info.crawl