############################################################################
require 'ghaki/namer/files/mixin'

############################################################################
module Ghaki module Namer module Files module MixinTesting
  MIX_MOD = Ghaki::Namer::Files::Mixin
  BAS_MOD = Ghaki::Namer::Files::Base
  describe MIX_MOD do

    class MyClass
      include MIX_MOD
    end

    context 'including objects' do
      subject { MyClass.new }
      it { should respond_to :file_namer }
      it { should respond_to :file_namer= }
    end

    describe '#file_namer' do
      subject { MyClass.new.file_namer }
      specify { subject.should be_an_instance_of(BAS_MOD) }
    end

  end
end end end end
############################################################################
