class ActionController::Base
  def self.present_with(presenter)
    define_method(:presenter) do
      @presenter ||= presenter.new(self)
    end 
    define_method(:index) do
      @presentation = self.presenter.present_collection(collection)
    end 
  end 
end 

