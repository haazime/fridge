# typed: strict
require 'sorbet-runtime'
require 'set'

module Team
  class Member
    extend T::Sig

    sig {returns(Person::Id)}
    attr_reader :person_id

    sig {returns(T::Set[Role])}
    attr_reader :roles

    sig {params(person_id: Person::Id, roles: T::Array[Role]).void}
    def initialize(person_id, roles)
      role_set = Set.new(roles)
      raise MemberHasTooManyRoles if role_set.size >= 3
      raise InvalidMultipleRoles if role_set == Set.new([Role::ProductOwner, Role::Developer])

      @person_id = person_id
      @roles = role_set
    end

    sig {params(other: Member).returns(T::Boolean)}
    def ==(other)
      self.person_id == other.person_id &&
        self.roles == other.roles
    end
  end
end
