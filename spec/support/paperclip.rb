require "paperclip/matchers"

RSpec.configure do |config|
	config.include Paperclip::Shoulda::Matchers
end

class Paperclip::Attachment
  def post_process; end
end
# 
# module Paperclip
#   class << self
#     def run(*args)
#       "100x100"
#     end
#   end
# end