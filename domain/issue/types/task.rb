# typed: strict
require 'sorbet-runtime'

module Issue
  module Types
    module Task
      class << self
        extend T::Sig
        include Type

        sig {override.returns(T::Boolean)}
        def can_estimate?
          false
        end

        sig {override.returns(String)}
        def to_s
          'task'
        end
      end
    end
  end
end
