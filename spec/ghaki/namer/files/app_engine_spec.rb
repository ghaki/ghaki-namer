############################################################################
require 'ghaki/app/engine'
require 'ghaki/namer/files/app'

############################################################################
module Ghaki module App module EngineTesting

SOURCE_MOD = Ghaki::Namer::Files::Base
TARGET_MOD = Ghaki::App::Engine

describe TARGET_MOD do

  ######################################################################
  context 'singleton' do
    subject { TARGET_MOD.instance }
    [ :file_namer,  :file_namer_opts,
      :file_namer=, :file_namer_opts=,
    ].each do |token|
      it { should respond_to token }
    end
  end

  ######################################################################
  context 'singleton method' do

    describe '#file_namer' do
    subject { TARGET_MOD.instance.file_namer }
      it { should be_an_instance_of(SOURCE_MOD) }
    end

    describe '#file_namer_opts' do
    subject { TARGET_MOD.instance.file_namer_opts }
      it { should be_an_instance_of(::Hash) }
    end

  end

end
end end end
############################################################################
