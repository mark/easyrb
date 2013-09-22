module Easyrb

  class Context

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :helpers

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(context, helpers)
      @context = context
      @helpers = Array(helpers)
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.[](context, helpers)
      new(context, helpers).generate_context
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def generate_context
      context.tap do |obj|
        helpers.each do |mod|
          obj.extend(mod)
        end
      end
    end

    private

    def bare_context
      @context
    end

    def context
      delegated_context || bare_context || Object.new
    end

    def delegated_context
      SimpleDelegator.new(bare_context) if bare_context && helpers.any?
    end

  end

end
