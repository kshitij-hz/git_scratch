require 'active_support/concern'

module CommonMethods
  extend ActiveSupport::Concern

  included do
    desc 'GitScratch rails app'

    argument :new_name, :type => :string, :default => ''
  end

  protected

  def perform
    puts "perform in commons....GitScratch"
  end

end
