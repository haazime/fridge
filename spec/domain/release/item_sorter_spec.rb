# typed: false
require 'domain_helper'

module Release
  RSpec.describe ItemSorter do
    let(:product_id) { Product::Id.create }
    let(:pbi_a) { Pbi::Id.create }
    let(:pbi_b) { Pbi::Id.create }
    let(:pbi_c) { Pbi::Id.create }
    let(:pbi_d) { Pbi::Id.create }
    let(:pbi_e) { Pbi::Id.create }

    context 'in same release' do
      it do
        release = Release.create(product_id, 'Release')
        release.add_item(pbi_a)
        release.add_item(pbi_b)
        release.add_item(pbi_c)

        sorter = described_class.new(release, pbi_c, release, 1)
        result = sorter.sort
        expect(result.map(&:items)).to eq [[pbi_c, pbi_a, pbi_b]]
      end
    end

    context 'between 2 releases' do
      it do
        release_x = Release.create(product_id, 'Release X')
        release_x.add_item(pbi_a)
        release_x.add_item(pbi_b)
        release_x.add_item(pbi_c)

        release_y = Release.create(product_id, 'Release Y')
        release_y.add_item(pbi_d)
        release_y.add_item(pbi_e)

        sorter = described_class.new(release_y, pbi_d, release_x, 2)
        result = sorter.sort
        expect(result.map(&:items)).to eq [[pbi_e], [pbi_a, pbi_d, pbi_b, pbi_c]]

        sorter = described_class.new(release_y, pbi_e, release_x, 4)
        result = sorter.sort
        expect(result.map(&:items)).to eq [[], [pbi_a, pbi_d, pbi_b, pbi_e, pbi_c]]

        sorter = described_class.new(release_x, pbi_c, release_y, 1)
        result = sorter.sort
        expect(result.map(&:items)).to eq [[pbi_a, pbi_d, pbi_b, pbi_e], [pbi_c]]

        sorter = described_class.new(release_y, pbi_c, release_x, 5)
        result = sorter.sort
        expect(result.map(&:items)).to eq [[], [pbi_a, pbi_d, pbi_b, pbi_e, pbi_c]]
      end
    end
  end
end