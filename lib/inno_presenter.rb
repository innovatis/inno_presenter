module InnoPresenter

  class Railtie < Rails::Railtie
    config.load_paths += "#{Rails.root}/app/presenters/"
  end

end

require File.join(File.dirname(__FILE__), 'inno_presenter', 'base')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'table_presenter')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'action_controller_extensions')
