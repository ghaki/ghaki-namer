############################################################################
require 'ghaki/namer/base'

############################################################################
module Ghaki module Namer module BaseTesting
  describe Ghaki::Namer::Base do

    ########################################################################
    TIME_VAL = Time.at(1269258809) # "2010/03/22 04:53:29"
    TIME_FMT = TIME_VAL.strftime(Ghaki::Namer::Base::TIME_STAMP_FMT)
    RAND_VAL = 32456
    RAND_FMT = Ghaki::Namer::Base::RAND_STAMP_FMT % RAND_VAL

    ########################################################################
    context 'object' do
      subject {Ghaki::Namer::Base.new }
      it { should respond_to :time_stamp }
      it { should respond_to :rand_stamp }
      it { should respond_to :rand_stamp_max }
      it { should respond_to :parse_names }
      it { should respond_to :ticket }
      it { should respond_to :ticket_generator }
    end

    ########################################################################
    describe '#new' do

      context 'with specific options' do
        MY_NOW = Time.now.to_i - 100
        MY_NUM = 100
        MY_MAX = 100
        subject do
          Ghaki::Namer::Base.new({
            :time_stamp     => MY_NOW,
            :rand_stamp     => MY_NUM,
            :rand_stamp_max => MY_MAX,
          })
        end
        specify { subject.time_stamp.should == MY_NOW }
        specify { subject.rand_stamp.should == MY_NUM }
        specify { subject.rand_stamp_max.should == MY_MAX }
      end
    end

    ########################################################################
    describe '#parse_names' do
      subject do
        Ghaki::Namer::Base.new({
          :time_stamp => TIME_VAL,
          :rand_stamp => RAND_VAL,
        })
      end
      it 'should see time default' do
        subject.parse_names(:time_stamp)[0].should == TIME_FMT
      end
      it 'should see rand default' do
        subject.parse_names(:rand_stamp)[0].should == RAND_FMT
      end
      it 'should see time with format' do
        subject.parse_names( [:time_stamp,'%Y/%m/%d'] )[0].should == '2010/03/22'
      end
      it 'should see rand with format' do
        fmt = '%08d'
        aft = fmt % RAND_VAL
        subject.parse_names( [:rand_stamp,fmt] )[0].should == aft
      end
      it 'should see static values' do
        out = subject.parse_names('ghaki','log')
        out[0].should == 'ghaki'
        out[1].should == 'log'
      end
      it 'should do complex formats' do
        subject.parse_names( [:format,'%0.3s','phxlb13'] )[0].should == 'phx'
      end
      it 'should do simple lambdas' do
        str = 'quack'
        fun = lambda do 'quack' end
        subject.parse_names(fun)[0].should == str
      end
      it 'should do complex lambdas' do
        fun = lambda do |major,minor| major + '_' + minor end
        subject.parse_names( [fun,'moo','12'] )[0].should == 'moo_12'
      end
    end

  end
end end end
############################################################################
