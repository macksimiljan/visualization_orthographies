ActionView::Base.send :include, BootstrapNavbar::Helpers

BootstrapNavbar.configure do |config|
  config.current_url_method = 'request.original_url'
end