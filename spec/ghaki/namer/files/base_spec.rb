require 'ghaki/namer/files/base'

module Ghaki module Namer module Files module BaseTesting
  BASE_MOD = Ghaki::Namer::Files::Base
describe BASE_MOD do

  TIME_VAL = Time.at(1269258809).gmtime # "2010/03/22 11:53:29"
  TIME_FMT = TIME_VAL.strftime(Ghaki::Namer::Base::TIME_STAMP_FMT)
  RAND_VAL = 32456
  RAND_FMT = Ghaki::Namer::Base::RAND_STAMP_FMT % RAND_VAL

  ########################################################################
  context 'object instance' do
    subject { BASE_MOD.new }
    it { should respond_to :create_working_dirs }
    it { should respond_to :put_file }
    it { should respond_to :put_files }
    it { should respond_to :assign_file }
    it { should respond_to :assign_files }
    it { should respond_to :reserve_file }
    it { should respond_to :reserve_files }
    it { should respond_to :freeze_file }
    it { should respond_to :freeze_files }
    it { should respond_to :get_file }
  end

  ########################################################################
  context 'name generation' do
    subject do
      BASE_MOD.new({
        :time_stamp => TIME_VAL,
        :rand_stamp => RAND_VAL,
        :path_generator => [ '/ghaki/project', 'logs' ],
        :base_generator => [:time_stamp]
      })
    end
    describe '#reserve_file' do
      it 'reserves file name' do
        subject.reserve_file( :log_file, 'error.log' )
        subject.get_file(:log_file).should == '/ghaki/project/logs/20100322_115329.error.log'
      end
    end
    describe '#assign_file' do
      it 'assign file name' do
        subject.assign_file( :log_file, 'error.log' )
        subject.get_file(:log_file).should == '/ghaki/project/logs/20100322_115329.error.log'
      end
    end
    describe '#put_file' do
      it 'stores file name' do
        subject.put_file( :log_file, './error.txt' )
        subject.get_file(:log_file).should == './error.txt'
      end
    end
  end

  ########################################################################
  describe '#create_working_dirs' do
    before(:all) do
      @my_path = '/tmp/bogus'
      @stor = BASE_MOD.new({
        :path_generator => [@my_path],
      }).assign_files({
        :log_file => 'error.txt',
      })
      ::FileUtils.expects(:mkdir_p).with(@my_path,is_a(Hash)).once
    end
    it 'calls mkdir' do
      @stor.create_working_dirs
    end
  end

end
end end end end
############################################################################
