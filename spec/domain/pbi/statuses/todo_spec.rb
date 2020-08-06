# typed: false
require 'domain_helper'

module Pbi
  module Statuses
    RSpec.describe Todo do
      describe '#can_assign?' do
        it do
          expect(described_class).to_not be_can_assign
        end
      end

      describe '#can_cancel_assignment?' do
        it do
          expect(described_class).to be_can_cancel_assignment
        end
      end

      describe '#can_remove?' do
        it do
          expect(described_class).to_not be_can_remove
        end
      end

      describe '#update_to_todo' do
        it do
          expect { described_class.update_to_todo }
            .to raise_error AssignProductBacklogItemNotAllowed
        end
      end

      describe '#update_by_cancel_assignment' do
        it do
          status = described_class.update_by_cancel_assignment
          expect(status).to eq Ready
        end
      end
    end
  end
end
