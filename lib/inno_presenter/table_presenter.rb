module InnoPresenter
  class TablePresenter < Base
    include Filterriffic::Presenter
    
    def filters
      []
    end 
    
    def columns
      []
    end 
    
    def present(obj)
      [
        # ... ,
        {}
      ]
    end 

    def search_column
      nil
    end 

  end 
end 

