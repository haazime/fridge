# typed: strict
require 'sorbet-runtime'

module Product
  module ProductRepository
    extend T::Sig
    extend T::Helpers
    interface!

    sig {abstract.params(id: Id).returns(Product)}
    def find_by_id(id); end

    sig {abstract.params(product: Product).void}
    def store(product); end
  end
end
