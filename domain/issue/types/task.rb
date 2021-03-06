# typed: strict
require 'sorbet-runtime'

module Issue
  module Types
    module Task
      class << self
        extend T::Sig
        include Type

        sig {override.returns(Status)}
        def initial_status
          Statuses::Ready
        end

        sig {override.returns(T::Boolean)}
        def must_have_acceptance_criteria?
          false
        end

        sig {override.returns(T::Boolean)}
        def update_by_preparation?
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
