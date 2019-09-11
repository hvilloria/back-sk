require_relative '../../config/environment'

namespace :products do
  desc 'load all products from a csv'

  task :load_from_csv do
    file = File.read(Rails.root.join('tmp', 'products.csv'))
    ProductGenerator.new(file).load
    Rails.logger.info('File was loaded successfully')
  rescue Errno::ENOENT
    Rails.logger.error('Could not process the csv, there is not a valid file')
  end
end
