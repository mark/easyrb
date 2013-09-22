require 'spec_helper'

include Easyrb

describe Runner do

  subject { Runner.new(template) }

  let(:template) { "Hello, <%= first_name %> <%= middle_initial %>. <%= last_name %>!" }

  module NamesModule
    def first_name;     "Jane";  end
    def middle_initial; "H";     end
    def last_name;      "Jones"; end
  end

  module FirstNameModule
    def first_name; "Barry"; end
  end

  module OtherNamesModule
    def middle_initial; "K";   end
    def last_name;      "Foo"; end
  end

  describe "with a locals hash" do

    let(:locals) { { first_name: "Bob", middle_initial: 'X', last_name: "Smith" } }
    
    it "should accept locals as a hash" do
      subject.run(locals: locals).must_equal "Hello, Bob X. Smith!"
    end

  end

  describe "with a context object" do

    let(:context) { Struct.new(:first_name, :middle_initial, :last_name).new("John", "Q", "Doe") }

    it "should use the provided context object" do
      subject.run(context: context).must_equal "Hello, John Q. Doe!"
    end

  end

  describe "with a helper module" do

    it "should include the helper module" do
      subject.run(helpers: NamesModule).must_equal "Hello, Jane H. Jones!"
    end

    it "should allow the helper module as an array" do
      subject.run(helpers: [NamesModule]).must_equal "Hello, Jane H. Jones!"
    end

    it "should allow multiple helper modules" do
      subject.run(helpers: [FirstNameModule, OtherNamesModule]).must_equal "Hello, Barry K. Foo!"
    end

    it "should use the last helper module for conflicts" do
      subject.run(helpers: [NamesModule, OtherNamesModule]).must_equal "Hello, Jane K. Foo!"
    end

  end

  describe "with all three" do

    let(:locals) { { last_name: "Lasty" } }

    FirstAndMiddle = Struct.new(:first_name, :middle_name)

    module MiddleNameModule
      def middle_initial
        middle_name[0]
      end
    end

    let(:context) { FirstAndMiddle.new("Sam", "Hello") }

    it "should use all three elements passed in" do
      subject.run(context: context, helpers: MiddleNameModule, locals: locals).must_equal "Hello, Sam H. Lasty!"
    end

  end

  describe "with bad options" do

    it "should raise an argument error with other stuff is passed in" do
      lambda { subject.run(local: {}) }.must_raise ArgumentError
    end
  end

end
