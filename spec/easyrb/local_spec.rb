require 'spec_helper'

include Easyrb

describe Local do

  describe "Local::[]" do

    let(:foo) { Object.new }
    let(:bar) { Object.new }

    it "the first argument should be self" do
      binding = Local[foo, {}]
      binding.eval("self").must_equal foo
    end

    it "the argument hash should become local variables" do
      binding = Local[foo, { a: 1 }]
      binding.eval("a").must_equal 1
    end

    it "the argument hash should allow non-simple variables" do
      binding = Local[foo, { b: bar }]
      binding.eval("b").must_equal bar
    end

    it "should allow multiple local variables" do
      binding = Local[foo, { c: :baz, d: 2 }]
      binding.eval("c").must_equal :baz
      binding.eval("d").must_equal 2
    end

    it "should not allow arguments not specified" do
      binding = Local[foo, {}]
      lambda { binding.eval("e") }.must_raise NameError
    end

  end

end
