require 'spec_helper'

include Easyrb

describe Context do

  describe "Context::[]" do

    module FooModule
      def foo; "foo"; end
    end

    module BarModule
      def bar; "bar"; end
    end

    class FooDummy < Struct.new(:foo, :quux); end

    describe "without a context object" do

      it "should return a new object if nothing is passed in" do
        Context[nil, nil].must_be_instance_of Object
      end

      it "shouldn't wrap the object if no helpers are passed in" do
        Context[nil, nil].wont_respond_to :__getobj__
        Context[nil, []].wont_respond_to :__getobj__
      end

      it "should include a module when one is passed in" do
        context = Context[nil, FooModule]
        context.must_be_instance_of Object
        context.must_respond_to :foo
        context.wont_respond_to :bar
      end

      it "should include modules when several are passed in" do
        context = Context[nil, [FooModule, BarModule]]
        context.must_be_instance_of Object
        context.must_respond_to :foo
        context.must_respond_to :bar
      end

    end

    describe "with a context object" do

      let(:bare) { FooDummy.new("boosh", "quux") }

      it "should return the context object if one is passed in" do
        Context[bare, nil].must_equal bare
      end

      it "shouldn't wrap the object if no helpers are passed in" do
        Context[bare, nil].wont_respond_to :__getobj__
      end

      it "should include a helper module if one is passed in" do
        Context[bare, BarModule].bar.must_equal "bar"
      end

      it "should wrap context methods with module methods" do
        context = Context[bare, FooModule]
        context.foo.must_equal "foo"
        context.quux.must_equal "quux"
      end

      it "should not change the object passed in" do
        Context[bare, FooModule].foo.wont_equal bare.foo
      end

    end

  end

end
