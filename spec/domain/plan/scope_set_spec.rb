# typed: strict
require 'domain_helper'

module Plan
  RSpec.describe ScopeSet do
    let(:issue_a) { Issue::Id.create }
    let(:issue_b) { Issue::Id.create }
    let(:issue_c) { Issue::Id.create }
    let(:issue_d) { Issue::Id.create }
    let(:issue_e) { Issue::Id.create }
    let(:order) { Order.new([issue_a, issue_b, issue_c, issue_d, issue_e]) }

    describe 'Make releases' do
      it do
        set = described_class.new
        releases = set.make_releases(order)
        expect(releases).to be_empty
      end

      it do
        set = described_class.new([Scope.new('Ph1', issue_b), Scope.new('Ph2', issue_d)])
        releases = set.make_releases(order)
        expect(releases).to eq [
          Release.new('Ph1', [issue_a, issue_b]),
          Release.new('Ph2', [issue_c, issue_d]),
        ]
      end
    end
  end
end
