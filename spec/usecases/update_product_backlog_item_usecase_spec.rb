require 'rails_helper'

RSpec.describe UpdateProductBacklogItemUsecase do
  let!(:product) { create_product }

  it do
    pbi = add_pbi(product.id, 'ORIGINAL_CONTENT')

    described_class.perform(pbi.id, Pbi::Content.from_string('UPDATED_CONTENT'))

    updated = ProductBacklogItemRepository::AR.find_by_id(pbi.id)
    expect(updated.content.to_s).to eq 'UPDATED_CONTENT'
  end
end
