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
        `git checkout --orphan latest_branch`
        sleep 3
        `git add -A`
        sleep 3
        `git commit -am "git_scratch initial commit"`
        sleep 3
        `git branch -D master`
        sleep 3
        `git branch -m master`
        sleep 3
        current_branch = `git rev-parse --abbrev-ref HEAD`
        puts "Current Branch => #{current_branch.to_s}"
        puts "Use command 'git push -f origin master' to update the repo"
        
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
        puts "current remotes => \n#{current_remotes.to_s}"
      end
    rescue => e
      puts "error => #{e}"
    end
  end

end
