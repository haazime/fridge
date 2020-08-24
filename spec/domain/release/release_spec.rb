# typed: false
require 'domain_helper'

module Release
  RSpec.describe Release do
    let(:product_id) { Product::Id.create }
    let(:item_a) { Feature::Id.create }
    let(:item_b) { Feature::Id.create }
    let(:item_c) { Feature::Id.create }

    let(:release) { described_class.create(product_id, 'Icebox') }

    describe 'create' do
      it do
        release = described_class.create(product_id, 'MVP')

        expect(release.title).to eq 'MVP'
        expect(release.items).to be_empty
      end
    end

    describe 'add_item' do
      it do
        release.add_item(item_a)
        expect(release.items).to match_array [item_a]
      end
    end

    describe 'remove_item' do
      it do
        release.add_item(item_a)
        release.add_item(item_b)
        release.add_item(item_c)

        release.remove_item(item_b)

        expect(release.items).to match_array [item_a, item_c]
      end
    end

    describe 'modify title' do
      it do
        release.add_item(item_a)
        release.add_item(item_b)
        release.add_item(item_c)

        release.modify_title('NEW_TITLE')

        expect(release.title).to eq 'NEW_TITLE'
        expect(release.items).to match_array [item_a, item_b, item_c]
      end
    end
  end
end
