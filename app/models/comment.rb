class Comment < ActiveRecord::Base
	validates :contents, :presence => true
	belongs_to :issue
end
