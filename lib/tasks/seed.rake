# seedファイルをモデル別に管理する記述です。
# カテゴリーなら、bundle exec rake db:seed:category　でおk

Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
  desc "Load the seed data from db/seeds/#{File.basename(file)}."
  task "db:seed:#{File.basename(file).gsub(/\..+$/, '')}" => :environment do
    load(file)
  end
end