# typed: strict
module Pbi
  class InvalidContent < ArgumentError; end
  class AssignProductBacklogItemNotAllowed < StandardError; end
  class ProductBacklogItemIsNotAssigned < StandardError; end
end
