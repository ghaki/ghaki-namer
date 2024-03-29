############################################################################
require 'ghaki/namer/files/app'

############################################################################
module Ghaki module Namer module Files module AppTesting

APP_MOD  = Ghaki::Namer::Files::App
BASE_MOD = Ghaki::Namer::Files::Base

describe APP_MOD do
  context 'singleton instance' do
    subject { APP_MOD.instance }

    it { should respond_to :file_namer }
    it { should respond_to :file_namer= }
    describe '#file_namer' do
      subject { APP_MOD.instance.file_namer }
      it { should be_an_instance_of(BASE_MOD) }
    end

    it { should respond_to :file_namer_opts }
    it { should respond_to :file_namer_opts= }
    describe '#file_namer_opts' do
      subject { APP_MOD.instance.file_namer_opts }
      it { should be_an_instance_of(::Hash) }
      context 'defaults' do
        # WORK GOES HERE
      end
    end

    it { should respond_to :file_namer_defs }
    it { should respond_to :file_namer_defs= }

  end
end
end end end end
