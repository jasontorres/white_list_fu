module WhiteListFu
  
  module ActMethods
    def self.included(base)
      base.send :extend, WhiteListFu::ClassMethods    
      base.send :include, WhiteListFu::InstanceMethods
    end
  end
  
  module ClassMethods
    def white_listed(options = {})
      include InstanceMethods
      before_validation :white_list_attributes
      class_inheritable_accessor :white_list_options  
      self.white_list_options = options
    end
  end
  
  module InstanceMethods
    include WhiteListHelper
    
    def white_list_attributes
      self.class.columns.each do |column|
        next unless (column.type == :string || column.type == :text)
        begin
        field = column.name.to_sym
        
        if !self.white_list_options[:except].nil?
          self[field] = white_list(self[field]) unless self.white_list_options[:except].include?(field)
        else
          self[field] = white_list(self[field])
        end

        rescue Exception => e
          puts e.message
        end
      end
    end
    
  end
  
end