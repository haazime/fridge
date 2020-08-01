# typed: strict
require 'sorbet-runtime'

module Pbi
  module Statuses
    module Preparation
      class << self
        extend T::Sig
        include Status

        sig {override.params(criteria: AcceptanceCriteria, size: StoryPoint).returns(Status)}
        def update_by_prepartion(criteria, size)
          if criteria.size > 0 && size != StoryPoint.unknown
            Ready
          else
            self
          end
        end

        sig {override.returns(String)}
        def to_s
          'preparation'
        end
      end
    end
  end
end
