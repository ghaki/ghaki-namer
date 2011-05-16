require 'ghaki/app/plugin'
require 'ghaki/namer/files/base'

module Ghaki #:nodoc:
module Namer #:nodoc:
module Files #:nodoc:

class App < Ghaki::App::Plugin
  app_plugin_make Base, :file_namer
  app_plugin_link :file_namer
end

end end end
