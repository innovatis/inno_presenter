module InnoPresenter

  class Railtie < Rails::Railtie
    initializer 'inno_presenter.initialize' do |app|
      assets_path = File.join(File.dirname(__FILE__), '..', 'assets')
      FileUtils.ln_s(File.expand_path(assets_path), File.join(Rails.root, 'public', 'inno_presenter'))

      app.config.load_paths += ["#{Rails.root}/app/presenters/"]
    end
  end

end

require File.join(File.dirname(__FILE__), 'inno_presenter', 'base')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'core_presenter')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'core_presenter', 'item')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'action_controller_extensions')
