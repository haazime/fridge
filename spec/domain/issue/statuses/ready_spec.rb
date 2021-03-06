# typed: false
require 'domain_helper'

module Issue
  module Statuses
    RSpec.describe Ready do
      describe '#available_activities' do
        it do
          a = described_class.available_activities
          expect(a).to eq activity_set([:remove_issue, :estimate_issue, :assign_issue_to_sprint])
        end
      end

      describe '#update_by_preparation' do
        context 'AcceptanceCriteria >= 1 and size == unknown' do
          it do
            status = described_class.update_by_preparation(
              acceptance_criteria(%w(AC1)),
              StoryPoint.unknown
            )
            expect(status).to eq Preparation
          end
        end

        context 'AcceptanceCriteria >= 1 and size != unknown' do
          it do
            status = described_class.update_by_preparation(
              acceptance_criteria(%w(AC1)),
              StoryPoint.new(3)
            )
            expect(status).to eq Ready
          end
        end

        context 'AcceptanceCriteria == 0 and size != unknown' do
          it do
            status = described_class.update_by_preparation(
              acceptance_criteria([]),
              StoryPoint.new(3)
            )
            expect(status).to eq Preparation
          end
        end
      end

      describe '#assign_to_sprint' do
        it do
          expect(described_class.assign_to_sprint).to eq Wip
        end
      end

      describe '#revert_from_sprint' do
        it do
          expect { described_class.revert_from_sprint }.to raise_error CanNotRevertFromSprint
        end
      end
    end
  end
end
