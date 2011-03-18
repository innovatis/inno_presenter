class ActionController::Base
  def self.magic_presenter
    model_class = self.name.
      sub(/Controller$/,'').
      sub(/^.*::/,'').
      singularize.
      constantize
    presenter_class = Class.new(InnoPresenter::TablePresenter)
    presenter_class.send(:define_method, :resource_class) { model_class }
    present_with(presenter_class)
  end 
  
  def self.present_with(presenter)
    define_method(:presenter) do
      @presenter ||= presenter.new(self)
    end 
    define_method(:index) do
      # dont need this right now...
      # @presentation = self.presenter.present_collection(collection)
    end 
  end 
end 

