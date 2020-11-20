# typed: strict
require 'sorbet-runtime'

module Plan
  class Plan
    extend T::Sig

    class << self
      extend T::Sig

      sig {params(product_id: Product::Id).returns(T.attached_class)}
      def create(product_id)
        new(product_id, [], IssueList.new([]))
      end

      sig {params(product_id: Product::Id, order: Order, scopes: ScopeSet).returns(T.attached_class)}
      def from_repository(product_id, order, scopes)
        new(product_id, order, scopes)
      end
    end

    sig {returns(Product::Id)}
    attr_reader :product_id

    sig {returns(T::Array[Release])}
    attr_reader :scoped

    sig {returns(IssueList)}
    attr_reader :not_scoped

    sig {params(product_id: Product::Id, scoped: T::Array[Release], not_scoped: IssueList).void}
    def initialize(product_id, scoped, not_scoped)
      @product_id = product_id
      @scoped = scoped
      @not_scoped = not_scoped
    end

    sig {params(name: String).void}
    def add_release(name)
      @scoped << Release.new(name, IssueList.new)
    end

    sig {params(name: String).void}
    def remove_release(name)
      @scoped.delete_if { |r| r.name == name }
    end

    sig {params(issue_id: Issue::Id).void}
    def add_issue(issue_id)
      @not_scoped = @not_scoped.append(issue_id)
    end

    sig {params(issue_id: Issue::Id).void}
    def remove_issue(issue_id)
      @not_scoped = @not_scoped.remove(issue_id)
    end
  end
end
