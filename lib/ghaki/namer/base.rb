############################################################################
module Ghaki
  module Namer
    class Base

      ######################################################################
      TIME_STAMP_FMT = '%Y%m%d_%H%M%S'
      RAND_STAMP_MAX = 65536 # FFFF+1
      RAND_STAMP_FMT = '%04x'

      ######################################################################
      attr_accessor :time_stamp, :rand_stamp, :rand_stamp_max,
        :ticket_generator

      ######################################################################
      def initialize opts={}
        @time_stamp     = opts[:time_stamp]     || Time.now
        @rand_stamp_max = opts[:rand_stamp_max] || RAND_STAMP_MAX
        @rand_stamp     = opts[:rand_stamp]     || rand(@rand_stamp_max)
        @ticket_generator = opts[:ticket_generator]
      end

      ######################################################################
      def parse_names *get_pile
        put_pile = []
        get_pile.each do |item|
          _parse_item put_pile, item
        end
        put_pile
      end

      ######################################################################
      def ticket
        @ticket ||= parse_names( *@ticket_generator).join('')
      end

      ######################################################################
      def debug_dump out_file
        out_file.box 'debug ' + self.class.to_s
        out_file.reindent({
          :time_stamp => self.time_stamp,
          :rand_stamp => self.rand_stamp,
          :rand_stamp_max => self.rand_stamp_max,
          :ticket_generator => self.ticket_generator,
        }.inspect)
      end

      ######################################################################
      ######################################################################
      private

      ######################################################################
      def _parse_item put_pile, item
        case item
        when String       then put_pile.push(item)
        when :time_stamp  then put_pile.push( @time_stamp.strftime(TIME_STAMP_FMT) )
        when :rand_stamp  then put_pile.push( RAND_STAMP_FMT % @rand_stamp )
        when Array        then _parse_complex put_pile, *item
        when Proc         then put_pile.push( item.call() )
        else
          raise ArgumentError, "Invalid Path Generator: #{item.class}"
        end
      end

      ######################################################################
      def _parse_complex put_pile, item, *info
        case item
        when :time_stamp  then put_pile.push( @time_stamp.strftime(info[0]) )
        when :rand_stamp  then put_pile.push( info[0] % @rand_stamp )
        when :format      then put_pile.push( info[0] % info[1] )
        when Proc         then put_pile.push( item.call( *info ) )
        else
          raise ArgumentError, "Invalid Path Generator: #{item.class}"
        end
      end

    end # class
  end # namespace
end # package
############################################################################
