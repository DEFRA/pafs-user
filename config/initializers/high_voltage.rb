HighVoltage.configure do |config|
  # This is a nested template that ultimately calls the gov uk template layout
  config.layout = 'pafs'
  # remove start page as root '/'
  # config.home_page = 'start'
end
