require File.expand_path('../common/my_methods', File.dirname(__FILE__))
module GitScratch
  module Generators
    class RenewGenerator < Rails::Generators::Base
      include CommonMethods

      def renew
        puts "Ksh..... into method..."
        perform
      end
    end
  end
end
