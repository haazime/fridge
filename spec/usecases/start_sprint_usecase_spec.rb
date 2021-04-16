require 'rails_helper'

RSpec.describe StartSprintUsecase do
  let!(:product) { create_product }

  it do
    sprint_id = described_class.perform(product.id)

    sprint = SprintRepository::AR.find_by_id(sprint_id)

    aggregate_failures do
      expect(sprint.product_id).to eq product.id
      expect(sprint.number).to eq 1
    end
  end
end