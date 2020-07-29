# typed: strict
require 'sorbet-runtime'

module ProductBacklogItemOrderRepository
  module AR
    class << self
      extend T::Sig
      include Pbi::OrderRepository

      DAO = Dao::ProductBacklog

      sig {override.params(product_id: Product::Id).returns(T.nilable(Pbi::Order))}
      def find_by_product_id(product_id)
        r = DAO.lock.find_by(dao_product_id: product_id.to_s)
        return nil unless r

        Pbi::Order.from_repository(
          product_id,
          r.product_backlog_item_ids.map { |id| Pbi::Id.from_string(id) }
        )
      end

      sig {override.params(order: Pbi::Order).void}
      def update(order)
        r = DAO.find_or_initialize_by(dao_product_id: order.product_id.to_s)
        r.product_backlog_item_ids = order.to_a
        r.save!
      end
    end
  end
end