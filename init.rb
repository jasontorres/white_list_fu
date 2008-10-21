# Include hook code here
require 'white_list_helper'
require 'white_list_fu'
ActiveRecord::Base.send(:include, WhiteListFu::ActMethods)
ActiveRecord::Base.send(:white_listed)