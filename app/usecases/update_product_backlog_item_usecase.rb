# typed: strict
require 'sorbet-runtime'

class UpdateProductBacklogItemUsecase < UsecaseBase
  extend T::Sig

  sig {void}
  def initialize
    @repository = T.let(ProductBacklogItemRepository::AR, Pbi::ItemRepository)
  end

  sig {params(pbi_id: Pbi::Id, content: Pbi::Content).void}
  def perform(pbi_id, content)
    pbi = @repository.find_by_id(pbi_id)
    pbi.update_content(content)
    @repository.update(pbi)
  end
end
