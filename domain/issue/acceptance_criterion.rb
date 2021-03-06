# typed: strict
require 'sorbet-runtime'

module Issue
  class AcceptanceCriterion
    extend T::Sig

    class << self
      extend T::Sig 

      sig {params(number: Integer, content: String).returns(T.attached_class)}
      def create(number, content)
        new(number, content)
      end

      sig {params(number: Integer, content: String).returns(T.attached_class)}
      def from_repository(number, content)
        new(number, content)
      end
    end

    sig {returns(Integer)}
    attr_reader :number

    sig {returns(String)}
    attr_reader :content

    sig {params(number: Integer, content: String).void}
    def initialize(number, content)
      @number = number
      @content = content
      @satisfied = T.let(false, T::Boolean)
    end
    private_class_method :new

    sig {params(content: String).void}
    def modify_content(content)
      @content = content
    end

    sig {void}
    def satisfy
      @satisfied = true
    end

    sig {void}
    def unsatisfy
      @satisfied = false
    end

    sig {returns(T::Boolean)}
    def satisfied?
      @satisfied
    end

    sig {params(number: Integer).returns(T::Boolean)}
    def same?(number)
      self.number == number
    end
  end
end
