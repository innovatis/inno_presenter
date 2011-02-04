module InnoPresenter
  class CorePresenter
    class Item
      ATTRIBUTES = [:tag, :assoc_arr, :joins, :attribute, :model_class, :type, :title, :formatter]
      
      def initialize(klass, key, opts={}, &blk)
        if key.kind_of?(Hash) 
          @joins, @attribute = nested_hash_pop(key)
   
          @assoc_arr = nested_hash_to_array(@joins)
          @tag = [*@assoc_arr, @attribute].join("_").to_sym
          @title = [*@assoc_arr, @attribute].map{|sym|sym.to_s.humanize}.join(" ")
          
          @model_class = @assoc_arr.inject(klass) do |kl, assoc|
            kl.reflect_on_all_associations.find{ |a| a.name == assoc }.klass
          end 
        else
          @title = key.to_s.humanize
          @assoc_arr = nil
          @joins = nil
          @attribute = key
          @model_class = klass
          @tag = key.to_sym
        end 
   
        @type = @model_class.columns.find{ |c| c.name == @attribute.to_s }.try(:type)
        
        opts.each do |opt, value|
          if ATTRIBUTES.include?(opt)
            instance_variable_set("@#{opt}", value)
          else 
            raise "Invalid attribute"
          end 
        end 

        if block_given?
          @formatter = blk
        end 
      end 
   
      def attribute_for_query
        if assoc_arr.blank?
          attribute
        else 
          "#{model_class.table_name}.#{attribute}"
        end 
      end 
      
      attr_accessor *ATTRIBUTES
   
      private ############################################################
      
      def nested_hash_to_array(hash)
        if hash.kind_of?(Hash)
          [hash.keys.first, nested_hash_to_array(hash.values.first)]
        else 
          [hash]
        end 
      end 
      
      def nested_hash_pop(hash)
        if (v = hash.values.first).kind_of?(Hash)
          new_hash_value, popped_value = nested_hash_pop(v)
          return [{hash.keys.first => new_hash_value}, popped_value]
        else 
          return [hash.keys.first, hash.values.first]
        end 
      end 
      
    end 
  end 
end 
