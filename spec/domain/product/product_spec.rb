# typed: false
require 'domain_helper'

module Product
  RSpec.describe Product do
    describe 'Create product' do
      it do
        product = described_class.create('ABC', 'DESC_ABC')

        aggregate_failures do
          expect(product.id).to_not be_nil
          expect(product.name).to eq 'ABC'
          expect(product.description).to eq 'DESC_ABC'
        end
      end
    end
  end
end
