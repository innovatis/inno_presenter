class ActionController::Base
  def self.present_with(presenter)
    define_method(:index) do
      @content = presenter.present_collection(collection)
    end 
  end 
end 

