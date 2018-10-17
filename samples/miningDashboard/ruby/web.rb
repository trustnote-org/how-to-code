require 'ramaze'
require "./miningHelper.rb"


class Home < Ramaze::Controller
  @@helper = Helper.new
  @@helper.init
  map '/'
  def index
    # "Hello Dashboard"
    render_file 'view/home.xhtml',:title => "Dashboard"
  end
end

class Api < Ramaze::Controller
    @@helper = Helper.new
    @@helper.init
    map '/api/'

    def address
        @@helper.get_address
    end
    def round
        @@helper.get_round_index
    end
end

class Api_Count < Ramaze::Controller
    @@helper = Helper.new
    @@helper.init
    map '/api/count'
    def unit
      @@helper.get_unit_count
    end
    def pow
      @@helper.get_pow_count
    end
    def trustme
      @@helper.get_trustme_count
    end
    def coinbase
        @@helper.get_coinbase_count
    end
    def ttt
        @@helper.get_ttt/1000000
    end
end

Ramaze.start :port => 80
