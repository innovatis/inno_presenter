module InnoPresenter
  class TablePresenter < Base
    include Filterriffic::Presenter

    def resource_class
      # Admin::CompaniesPresenter => Company
      self.class.name.
        sub(/Presenter$/,'').
        sub(/^.*::/,'').
        singularize.
        constantize
    end 

    def resource_path(obj)
      url_for(obj)
    end 
    
    def items
      []
    end 

    def filters
      items.map{|f| f[:tag]}
    end 
    
    def columns
      items.map{|f| f[:tag]}
    end 

    def extra(obj)
      {}
    end 
    
    def search_column
      nil
    end 

    ####################################################################
    # Wouldn't recommend overriding from here on down. #################
    ####################################################################
    
    def present(obj)
      columns.map do |f| 
        item = items.find{|i|i[:tag] == f}
        obj.send(item[:field])
      end + [
        {'link' => resource_path(obj)}.merge(extra(obj))
      ]
    end 

    def item(field, opts={})
      type = resource_class.columns.find{|c|c.name == field.to_s}.type
      # TODO: revise supported types in filterriffic
      { 
        :tag => field,
        :type => type,
        :title => field.to_s.humanize,
        :field => field
      }
    end 

    def present_filters
      filters.map do |f| 
        item = items.find{|i|i[:tag] == f}
        { 
          :tag   => item[:tag],
          :type  => item[:type],
          :title => item[:title] # todo pick one of these names.
        }      
      end
    end 
    
    def present_columns
      columns.map do |f| 
        item = items.find{|i|i[:tag] == f}
        { 
          :field => item[:field],
          :title => item[:title] # todo pick one of these names.
        }      
      end
    end 

    def present_search_column
      search_column
    end 
    
  end 
end 

