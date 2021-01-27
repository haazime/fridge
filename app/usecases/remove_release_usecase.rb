# typed: strict
require 'sorbet-runtime'

class RemoveReleaseUsecase < UsecaseBase
  extend T::Sig

  sig {void}
  def initialize
    @repository = T.let(PlanRepository::AR, Plan::PlanRepository)
  end

  sig {params(product_id: Product::Id, roles: Team::RoleSet, name: String).void}
  def perform(product_id, roles, name)
    plan = @repository.find_by_product_id(product_id)

    new_scheduled = plan.scheduled.remove(name)
    plan.update_scheduled(roles, new_scheduled)

    @repository.store(plan)
  end
end
