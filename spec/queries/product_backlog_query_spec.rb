# typed: false
require 'rails_helper'

RSpec.describe ProductBacklogQuery do
  let!(:product) { create_product }

  it '優先順位順になっていること' do
    pbi_a = add_pbi(product.id, 'AAA').id
    pbi_b = add_pbi(product.id, 'BBB').id
    pbi_c = add_pbi(product.id, 'CCC').id

    item_ids = described_class.call(product.id.to_s)[0].items.map(&:id)

    expect(item_ids).to eq [pbi_a, pbi_b, pbi_c].map(&:to_s)
  end

  it 'リリースを返すこと' do
    pbi_a = add_pbi(product.id, 'AAA').id
    pbi_b = add_pbi(product.id, 'BBB').id
    pbi_c = add_pbi(product.id, 'CCC').id

    release = described_class.call(product.id.to_s).first

    expect(release.title).to eq Release::Release::DEFAULT_TITLE
  end

  it 'リリースの削除可否を返すこと' do
    add_pbi(product.id, 'AAA')

    releases = described_class.call(product.id.to_s)

    expect(releases.first).to_not be_can_remove
  end

  it 'アイテムがまだない場合は空配列を返すこと' do
    releases = described_class.call(product.id.to_s)
    expect(releases).to be_empty
  end

  it '受け入れ基準がある場合は受け入れ基準を含むこと' do
    pbi = add_pbi(product.id, acceptance_criteria: %w(ac1 ac2 ac3))

    item = described_class.call(product.id.to_s)[0].items.first
    expect(item.criteria.map(&:content)).to eq %w(ac1 ac2 ac3) 
  end

  it '各操作の可否を返すこと' do
    pbi = add_pbi(product.id, acceptance_criteria: %w(ac1), size: 1)

    item = described_class.call(product.id.to_s)[0].items.first

    aggregate_failures do
      expect(item.status).to be_can_assign
      expect(item.status).to_not be_can_cancel_assignment
      expect(item.status).to be_can_remove
      expect(item.status).to be_can_estimate_size
    end
  end
end
