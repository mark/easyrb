module Easyrb

  class Local

    ################
    #              #
    # Declarations #
    #              #
    ################
    
    attr_reader :context, :hash

    ###############
    #             #
    # Constructor #
    #             #
    ###############
    
    def initialize(context, hash)
      @context = context
      @hash    = hash || Hash.new
    end

    #################
    #               #
    # Class Methods #
    #               #
    #################
    
    def self.[](context, hash)
      new(context, hash).generate_binding
    end

    ####################
    #                  #
    # Instance Methods #
    #                  #
    ####################
    
    def generate_binding
      locals_function.(*values)
    end

    private

    def function_string
      locals_string = "#{ keys.join(', ') }, = args;" if keys.any?
      
      "->(*args) { #{ locals_string } ->(){}.binding }"
    end

    def keys
      hash.keys
    end

    def locals_function
      context.instance_eval(function_string)
    end

    def values
      hash.values
    end

  end

end
