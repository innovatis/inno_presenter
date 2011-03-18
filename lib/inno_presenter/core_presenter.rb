module InnoPresenter
  class CorePresenter < Base

    def self.title
      self.name.sub(/^.*::/,'').sub(/Presenter$/,'')
    end 
    
    def resource_class
      default_resource_class
    end 

    def resource_path(obj)
      url_for(obj)
    end 
    
    def items
      resource_class.columns.map do |c|
        item(resource_class.human_attribute_name(c.name))
      end
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
      @_default_resource_class ||= self.class.name.
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

