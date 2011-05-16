require 'ghaki/app/mixable'
require 'ghaki/namer/files/app'

module Ghaki #:nodoc:
module Namer #:nodoc:
module Files #:nodoc:

module Mixin
  include Ghaki::App::Mixable
  app_mixin_accessor App, :file_namer
end

end end end 
