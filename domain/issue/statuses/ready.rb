# typed: strict
require 'sorbet-runtime'

module Issue
  module Statuses
    module Ready
      class << self
        extend T::Sig
        include Status

        sig {override.returns(Activity::Set)}
        def available_activities
          Activity::Set.from_symbols([:remove_issue, :estimate_issue, :assign_issue_to_sprint])
        end

        sig {override.params(criteria: AcceptanceCriteria, size: StoryPoint).returns(Status)}
        def update_by_preparation(criteria, size)
          if Preparation.update_by_preparation(criteria, size) == self
            self
          else
            Preparation
          end
        end

        sig {override.returns(Status)}
        def assign_to_sprint
          Wip
        end

        sig {override.returns(Status)}
        def revert_from_sprint
          raise CanNotRevertFromSprint
        end

        sig {override.returns(String)}
        def to_s
          'ready'
        end
      end
    end
  end
end
