require 'erb'
require 'delegate'

module Easyrb

  class Runner

    ################
    #              #
    # Declarations #
    #              #
    ################

    attr_reader :erb_template

    VALID_OPTIONS = [:context, :helpers, :locals]

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(erb_template)
      @erb_template = erb_template
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def run(options = {})
      validate_options!(options)

      object  = Easyrb::Context[options[:context], options[:helpers]]
      binding = Easyrb::Local[object, options[:locals]]

      erb.result(binding)
    end

    private

    def erb
      ERB.new(erb_template)
    end

    def validate_options!(options)
      bad_keys = options.keys - VALID_OPTIONS

      if bad_keys.any?
        bad_key_string = bad_keys.map { |k| k.inspect }.join(', ')
        raise ArgumentError, "#erb invalid keys: #{ bad_key_string }"
      end
    end
    
  end

end
