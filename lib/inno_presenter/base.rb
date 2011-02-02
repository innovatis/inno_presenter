class InnoPresenter::Base
  def initialize(controller)
    @controller = controller
    @controller_helpers = @controller._helper_methods
  end 
  
  def present_collection(coll, presenter=:present)
    coll.map{ |obj| send(presenter, obj) }
  end 

  def present(obj)
    raise NotImplementedError
  end 

  def method_missing(s, *a)
    if @controller_helpers.include?(s)
      @controller.send(s, *a)
    else
      super(s, *a)
    end 
  end 
  
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
end 

