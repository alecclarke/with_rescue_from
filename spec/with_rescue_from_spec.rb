RSpec.describe WithRescueFrom do
  let(:klass) do
    Class.new do
      class MethodWithArgsError < StandardError; end
      class MethodWithBlockError < StandardError; end
      class MethodWithKwargsError < StandardError; end
      class MethodWithoutArgsError < StandardError; end

      prepend WithRescueFrom
      include ActiveSupport::Rescuable

      with_rescue_from :method_with_args, :method_without_args, :method_with_kwargs, :method_with_a_block, :method_with_a_defined_rescue

      rescue_from StandardError do |e|
        @result = e.message
      end

      attr_reader :result

      def method_with_args(first_arg, second_arg)
        first_arg + second_arg
        raise MethodWithArgsError.new
      end

      def method_without_args
        raise MethodWithoutArgsError.new
      end

      def method_with_kwargs(first_arg:, second_arg:)
        first_arg + second_arg
        raise MethodWithKwargsError.new
      end

      def method_with_a_block(&block)
        block.call
      end

      def method_with_a_defined_rescue
        raise StandardError.new
      rescue => e
        #NO-OP
      end

      def method_not_included_in_with_rescue_from
        raise StandardError.new
      end
    end
  end

  let(:klass_instance) { klass.new }

  context "when the method accepts positional arguments" do
    it "rescues the exception in the rescue_from handler" do
      klass_instance.method_with_args(1,2)

      expect(klass_instance.result).to eq("MethodWithArgsError")
    end
  end

  context "when the method accepts keyword arguments" do
    it "rescues the exception in the rescue_from handler" do
      klass_instance.method_with_kwargs(first_arg: 1, second_arg: 2)

      expect(klass_instance.result).to eq("MethodWithKwargsError")
    end
  end

  context "when the method doesn't accept arguments" do
    it "rescues the exception in the rescue_from handler" do
      klass_instance.method_without_args

      expect(klass_instance.result).to eq("MethodWithoutArgsError")
    end
  end

  context "when the methods accepts a block argument" do    
    it "rescues the exception in the rescue_from handler" do
      klass_instance.method_with_a_block do
        raise MethodWithBlockError.new
      end

      expect(klass_instance.result).to eq("MethodWithBlockError")
    end
  end

  context "when the method doesn't raise an exception" do
    it "doesn't call the rescue_from handler" do
      expect(klass_instance.method_with_a_block { 1 + 2 }).to eq(3)
      expect(klass_instance.result).to be_nil
    end
  end

  context "when the method isn't included in with_rescue_from" do
    it "doesn't handle the exception" do
      expect { klass_instance.method_not_included_in_with_rescue_from }.to raise_error(StandardError)
    end
  end

  context "when the method handles the exception internally" do
    it "doesn't call the rescue_from handler" do
      expect { klass_instance.method_with_a_defined_rescue }.not_to raise_error
      expect(klass_instance.result).to be_nil
    end
  end
end
