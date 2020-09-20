# typed: false
require 'rails_helper'

RSpec.describe ModifyReleaseTitleUsecase do
  let!(:product) { create_product }

  it do
    release = add_release(product.id, 'OLD_TITLE')

    described_class.perform(release.id, 'NEW_TITLE')

    stored = ReleaseRepository::AR.find_by_id(release.id)

    expect(stored.title).to eq 'NEW_TITLE'
  end
end
