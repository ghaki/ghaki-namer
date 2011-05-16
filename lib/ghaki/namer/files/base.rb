require 'fileutils'
require 'ghaki/namer/base'

module Ghaki #:nodoc:
module Namer #:nodoc:
module Files #:nodoc:

class Base < Namer::Base

  ######################################################################
  attr_accessor :path_generator, :base_generator,
    :suffix_map, :filename_map

  ######################################################################
  def initialize opts={} ; super opts
    @suffix_map = {}
    @filename_map  = {}
    @path_generator = opts[:path_generator] || []
    @base_generator = opts[:base_generator] || []
  end

  ######################################################################
  def debug_dump out_file; super
    out_file.puts( {
      :suffix_map => self.suffix_map,
      :path_generator => self.path_generator,
      :base_generator => self.base_generator,
      :filename_map => self.filename_map,
    }.inspect )
  end

  ######################################################################
  def generate_filename key
    cur_path = parse_names( *@path_generator )
    cur_base = parse_names( *@base_generator ).
      push( @suffix_map[key] ).join('.')
    File.join( cur_path, cur_base )
  end

  ######################################################################
  def create_working_dirs opts={}
    @filename_map.values.each do |fname|
      ::FileUtils.mkdir_p( File.dirname(fname), opts )
    end
    self
  end

  ######################################################################
  # RESERVE FILE NAMES
  ######################################################################

  #---------------------------------------------------------------------
  def reserve_file token, new_suffix
    old_suffix = @suffix_map[token]
    if old_suffix.nil?
      @suffix_map[token] = new_suffix
    elsif old_suffix != new_suffix
      raise NamerError, "Inconsistent File Extension: #{token.to_s} (#{old_suffix}/#{new_suffix})"
    end
  end

  #---------------------------------------------------------------------
  def reserve_files list
    list.each do |key,val| reserve_file key, val end
    self
  end

  ######################################################################
  # PUT FILENAMES USING OPTS
  ######################################################################

  #---------------------------------------------------------------------
  def opt_put_file opts, token
    put_file token, opts[token] if opts.has_key?(token)
  end

  #---------------------------------------------------------------------
  def opt_put_files opts, *tokens
    tokens.each do |token| opt_put_file token, opts end
  end

  ######################################################################
  # PUT FILENAMES DIRECTLY
  ######################################################################

  #---------------------------------------------------------------------
  def put_file token, new_fname
    old_fname = @filename_map[token]
    if old_fname.nil?
      @filename_map[token] = new_fname
    elsif old_fname != new_fname
      raise NamerError, "Inconsistent Filenaming: #{token.to_s}"
    end
    new_fname
  end

  #---------------------------------------------------------------------
  def put_files list
    list.each do |key,val| put_file key, val end
    self
  end

  ######################################################################
  # FREEZE FILENAMES
  ######################################################################

  #---------------------------------------------------------------------
  def freeze_file token
    @filename_map[token] || put_file( token, generate_filename( token ) )
  end

  #---------------------------------------------------------------------
  def freeze_files tokens
    tokens.each do |token| freeze_file token end
    self
  end

  #####################################################################
  alias_method :get_file, :freeze_file

  ######################################################################
  # ASSIGNING FILE NAMES
  ######################################################################

  def assign_file token, suffix
    reserve_file token, suffix
    freeze_file token
  end

  ######################################################################
  def assign_files list
    list.each do |key,val| assign_file key, val end
    self
  end

  ######################################################################
  def file_named? token
    @filename_map[token].nil?
  end

end
end end end
