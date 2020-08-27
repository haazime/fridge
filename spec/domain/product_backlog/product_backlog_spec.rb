# typed: false
require 'domain_helper'

module ProductBacklog
  RSpec.describe ProductBacklog do
    let(:product_id) { Product::Id.create }

    describe 'Change item priority' do
      let(:pbl) { described_class.create(product_id) }
      let(:item_a) { Feature::Id.create }
      let(:item_b) { Feature::Id.create }
      let(:item_c) { Feature::Id.create }
      let(:item_d) { Feature::Id.create }
      let(:item_e) { Feature::Id.create }

      before do
        pbl.add_item(item_a)
        pbl.add_item(item_b)
        pbl.add_item(item_c)
        pbl.add_item(item_d)
        pbl.add_item(item_e)
      end

      it do
        pbl.move_priority_up_to(item_c, item_b)
        expect(pbl.items).to eq [item_a, item_c, item_b, item_d, item_e]
      end

      it do
        pbl.move_priority_up_to(item_e, item_a)
        expect(pbl.items).to eq [item_e, item_a, item_b, item_c, item_d]
      end

      it do
        pbl.move_priority_down_to(item_c, item_d)
        expect(pbl.items).to eq [item_a, item_b, item_d, item_c, item_e]
      end

      it do
        pbl.move_priority_down_to(item_e, item_a)
        expect(pbl.items).to eq [item_e, item_a, item_b, item_c, item_d]
      end
    end
  end
end
