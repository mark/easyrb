require 'spec_helper'
require 'tempfile'

describe String do

  it "should respond to #erb" do
    "Welcome to <%= app %>".erb(locals: { app: "Rails 5.0" }).must_equal "Welcome to Rails 5.0"
  end

end

describe File do

  it "should respond to #erb" do
    Tempfile.new('template.erb') do |f|
      f.write "Welcome to <%= app %>"

      f.erb(locals: { app: "Rails 6.0" }).must_equal "Welcome to Rails 6.0"
    end
  end

  it "should respond to ::erb" do
    Tempfile.new('template.erb') do |f|
      f.write "Thanks for <%= app %>"

      File.erb(f.path, locals: { app: "Rails 7.0" }).must_equal "Thanks for Rails 7.0"
    end
  end

end
