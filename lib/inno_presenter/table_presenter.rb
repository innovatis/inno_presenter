module InnoPresenter
  class TablePresenter < Base
    include Filterriffic::Presenter

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
        item = items.find{|i|i[:tag] == f}
        
        val = obj
        val = item[:proxy].call(val)     if item[:proxy]
        val = val.send(item[:field])
        val = item[:formatter].call(val) if item[:formatter]
        
        val
      end + [
        {'link' => resource_path(obj)}.merge(extra(obj))
      ]
    end 

    def belongs_to_item(assoc, field, opts={})
      # item(:company_name, :proxy => proc{|o|o.company}, :joins => :company, :title => "Company", :field => :name, :type => :string),
      assoc_class = resource_class.reflect_on_all_associations.find{|a|a.name == assoc}.klass
      type = assoc_class.columns.find{|c|c.name == field.to_s}.try(:type)
      { 
        :tag       => "#{assoc}_#{field}".to_sym,
        :type      => type,
        :title     => "#{assoc} #{field}".humanize,
        :field     => field,
        :proxy     => proc{|o|o.send assoc},
        :joins     => assoc,
        :formatter => default_formatter(type)
      }.merge(opts)
    end 

    def item(field, opts={})
      type = resource_class.columns.find{|c|c.name == field.to_s}.try(:type)
      { 
        :tag       => field,
        :type      => type,
        :title     => field.to_s.humanize,
        :field     => field,
        :formatter => default_formatter(type)
      }.merge(opts)
    end 

    def default_formatter(type)
      case type
      when :datetime
        proc{|f|f.try(:to_s, :short)}
      else 
        nil
      end 
    end 
    
    def present_filters
      filters.map do |f| 
        item = items.find{|i|i[:tag] == f}
        { 
          :tag   => item[:tag],
          :type  => item[:type],
          :joins => item[:joins],
          :field => item[:field],
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

