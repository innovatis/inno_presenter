require 'fileutils'

module InnoPresenter

  class Railtie < Rails::Railtie
    initializer 'inno_presenter.initialize' do |app|
      app.config.autoload_paths += [Rails.root + "/app/presenters/"]
    end
  end

end

require File.join(File.dirname(__FILE__), 'inno_presenter', 'base')
