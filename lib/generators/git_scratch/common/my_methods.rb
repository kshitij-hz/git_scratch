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
    reset_all_commits
  end

  def reset_all_commits
    begin
       if get_choice("Want to reset all commits (y/n) : ")
        puts "Resetting all commit messages"
        current_branch = `git rev-parse --abbrev-ref HEAD`
        puts "Current Branch => #{current_branch.to_s}"
        `git checkout --orphan latest_branch`
        `git add -A`
        `git commit -am "git_scratch initial commit"`
        `git branch -D master`
        `git branch -m master`
        `git push -f origin master` if @remote_path.present?

        puts "\t Done..."
      end
    rescue => e
      puts "error => #{e}"
    end
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
        if get_choice
          puts "Enter remote path :"
          @remote_path = STDIN.gets.strip.downcase  
          puts "Invalid remote path." if @remote_path.blank?
        end
      end  
      
      puts "Changing remote path"
      if @remote_path.present?
        `git remote add origin #{@remote_path}`
      end
      current_remotes = `git remote -v`
      if current_remotes.to_s.strip.present?
        puts "current remotes => \n #{current_remotes.to_s}"
      end
      puts "\t Done..."
    rescue => e
      puts "error => #{e}"
    end
  end

end
