# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :generate_contract do
  path = ENV['CONTRACT_PATH'] || "/Users/jiangjinyang/workspace/champs"
  # `cp #{path}/contracts/* contract/src/`
  # puts `cd contract/src/ && solc -o ../abi --bin --abi --optimize HackathonFactory.sol`
  %w{HackathonFactory Hackathon}.each do |f|
    # source_f = "#{f}_sol_#{f}"
    # `cp contract/abi/#{source_f}.abi contract/abi/#{f}.abi`
    # `cp contract/abi/#{source_f}.bin contract/abi/#{f}.bin`
    puts `java -jar vendor/console-3.3.1-all.jar solidity generate contract/abi/#{f}.bin contract/abi/#{f}.abi -o contract -p org.hacks`
  end

  # compile
  puts `javac -classpath "#{Rails.root}/vendor/console-3.3.1-all.jar" contract/org/hacks/*.java`

end
