# typed: strict
require 'sorbet-runtime'

module Team
  module TeamRepository
    extend T::Sig
    extend T::Helpers
    interface!

    sig {abstract.params(team: Team).void}
    def store(team); end

    sig {abstract.params(id: Id).returns(Team)}
    def find_by_id(id); end
  end
end
