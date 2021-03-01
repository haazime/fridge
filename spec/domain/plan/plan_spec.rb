# typed: false
require 'domain_helper'

module Plan
  RSpec.describe Plan do
    let!(:product_id) { Product::Id.create }

    describe 'Create' do
      it do
        plan = described_class.create(product_id)

        aggregate_failures do
          expect(plan.product_id).to eq product_id
          expect(plan.releases.size).to eq 1
          expect(plan.release(1).issues).to eq issue_list
        end
      end
    end

    let(:plan) { described_class.create(product_id) }
    let(:issue_a) { Issue::Id.create }
    let(:issue_b) { Issue::Id.create }
    let(:issue_c) { Issue::Id.create }
    let(:issue_d) { Issue::Id.create }
    let(:issue_e) { Issue::Id.create }
    let(:issue_f) { Issue::Id.create }
    let(:issue_g) { Issue::Id.create }
    let(:po_roles) { team_roles(:po) }
    let(:dev_roles) { team_roles(:dev) }

    describe 'Update release' do
      it do
        release = plan.release(1).tap do |r|
          r.append_issue(issue_a)
          r.append_issue(issue_b)
          r.append_issue(issue_c)
        end

        plan.update_release(release)

        expect(plan.release(1).issues).to eq issue_list(issue_a, issue_b, issue_c)
      end
    end
  end
end
