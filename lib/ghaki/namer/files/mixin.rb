############################################################################
require 'ghaki/namer/files/app'

############################################################################
module Ghaki module Namer
  module Files
    module Mixin

      attr_writer :file_namer

      def file_namer
        @file_namer ||= Ghaki::Namer::Files::App.instance.file_namer
      end

    end # helper
  end # namespace
end end # package
############################################################################
