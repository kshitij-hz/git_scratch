require 'active_support/concern'

module CommonMethods
  extend ActiveSupport::Concern

  included do
    desc 'GitScratch rails app'

    argument :new_remote_path, :type => :string, :default => ''
  end

  protected

  def perform
    puts "perform in commons....GitScratch"
    @remote_path = new_remote_path.to_s.strip
    change_remote_path
  end

  def get_choice(msg = '')
    puts "#{msg}" if msg.present?
    flag = STDIN.gets.strip.downcase
    if flag == 'n'
      return false
    elsif flag == 'y'
      return true
    else
      puts "Please enter 'y' or 'n' :"
      get_choice
    end
  end

  def change_remote_path
    begin
      `git remote remove origin`
      if @remote_path.blank?
        puts "Want to add new remote path(y/n):"
        if get_choice('Enter remote path :')
          @remote_path = STDIN.gets.strip.downcase  
          puts "Invalid remote path." if @remote_path.blank?
        end
      end  
      
      puts "Changing remote path"
      if @remote_path.present?
        `git remote add origin #{@remote_path}`
      end
      puts "Current remote paths ->"
      puts `git remote -v`
    rescue => e
      puts "error => #{e}"
    end
  end

end
