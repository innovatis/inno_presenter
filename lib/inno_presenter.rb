require 'fileutils'

module InnoPresenter

  class Railtie < Rails::Railtie
    initializer 'inno_presenter.initialize' do |app|
      assets_path = File.join(File.dirname(__FILE__), '..', 'assets')
      
      target = File.join(Rails.root, 'public', 'lib', 'inno_presenter')
      FileUtils.rm_r(target) if File.exist?(target)
      FileUtils.cp_r(File.expand_path(assets_path), target)

      app.config.autoload_paths += ["#{Rails.root}/app/presenters/"]

      javascripts = {
        :inno_presenter => [
          '/lib/inno_presenter/jquery.dataTables.js'
        ]
      }
      
      stylesheets = { 
        :inno_presenter => []
      }

      ActionView::Helpers::AssetTagHelper.register_javascript_expansion javascripts
      ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion stylesheets
      
    end
  end

end

require File.join(File.dirname(__FILE__), 'inno_presenter', 'base')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'core_presenter')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'core_presenter', 'item')
require File.join(File.dirname(__FILE__), 'inno_presenter', 'action_controller_extensions')
