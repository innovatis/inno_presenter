class ActionController::Base
  def self.present_with(presenter)
    define_method(:index) do
      @presenter    = presenter.new(self)
      @presentation = @presenter.present_collection(collection)
    end 
  end 
end 

