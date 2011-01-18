############################################################################
require 'singleton'
require 'ghaki/namer/files/base'

############################################################################
module Ghaki module Namer
  module Files
    class App
      include Singleton

      #---------------------------------------------------------------------
      DEF_FILE_NAMER_OPTS = {}

      #---------------------------------------------------------------------
      attr_writer :file_namer
      attr_accessor :file_namer_opts

      #---------------------------------------------------------------------
      def file_namer
        @file_namer ||= Ghaki::Namer::Files::Base.new(self.file_namer_opts)
      end

      #---------------------------------------------------------------------
      def file_namer_opts
        @file_namer_opts ||= DEF_FILE_NAMER_OPTS.dup
      end

    end # class
  end end # namespace
end # package
############################################################################

############################################################################
begin
  require 'ghaki/app/engine'
  Ghaki::App::Engine.class_eval do
    def file_namer           ; Ghaki::Namer::Files::App.instance.file_namer            end
    def file_namer= val      ; Ghaki::Namer::Files::App.instance.file_namer = val      end
    def file_namer_opts      ; Ghaki::Namer::Files::App.instance.file_namer_opts       end
    def file_namer_opts= val ; Ghaki::Namer::Files::App.instance.file_namer_opts = val end
  end
rescue LoadError
end
############################################################################
