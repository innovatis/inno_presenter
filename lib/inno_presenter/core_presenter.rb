module InnoPresenter
  class CorePresenter < Base

    def resource_class
      default_resource_class
    end 

    def resource_path(obj)
      url_for(obj)
    end 
    
    def items
      resource_class.columns.map{|c|item(c.name)}
    end 

    def filters
      items.map{|i| i.tag}
    end 
    
    def columns
      items.map{|i| i.tag}
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
    
    def default_resource_class
      # Admin::CompaniesPresenter => Company
      self.class.name.
        sub(/Presenter$/,'').
        sub(/^.*::/,'').
        singularize.
        constantize
    end 

    def present(obj)
      columns.map do |f| 
        item = items.find{|i|i.tag == f}
        
        val = obj
        if item.assoc_arr.present?
          val = item.assoc_arr.inject(val){|a,v|a.try(v)}
        end 
        val = val.try(item.attribute)
        if f=item.formatter
          if f.arity == 2
            val = f.call(val, obj)
          else 
            val = f.call(val)
          end 
        end 
        val
      end + [
        {'link' => resource_path(obj)}.merge(extra(obj))
      ]
    end 

    def item(key, opts={})
      Item.new(resource_class, key, opts)
    end 

    def present_filters_for_frontend
      filters.map do |f| 
        item = items.find{|i|i.tag == f}
        { 
          :tag   => item.tag,
          :type  => item.type,
          :field => item.attribute,
          :title => item.title
        }      
      end
    end 

    def present_filters_for_backend
      filters.map do |f| 
        items.find{|i|i.tag == f}
      end
    end 
    
    def present_columns
      columns.map do |f| 
        item = items.find{|i|i.tag == f}
        { 
          :field => item.attribute,
          :title => item.title
        }      
      end
    end 

    def present_search_column
      search_column
    end 
    
  end 

end 


