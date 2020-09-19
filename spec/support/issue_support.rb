# typed: true
require_relative '../domain_support/issue_domain_support'

module IssueSupport
  include IssueDomainSupport

  def add_issue(product_id, description = 'DESC', acceptance_criteria: [], size: nil, release: nil, wip: false)
    issue = perform_add_issue(product_id, description)

    add_acceptance_criteria(issue, acceptance_criteria) if acceptance_criteria

    estimate_feature(issue.id, size) if size

    add_issue_to_release(issue.id, release) if release

    start_issue_development(issue.id) if wip

    IssueRepository::AR.find_by_id(issue.id)
  end
  alias_method :add_feature, :add_issue

  def add_acceptance_criteria(issue, contents_or_criteria)
    criteria = contents_or_criteria.map do |cc|
      cc.is_a?(String)? acceptance_criterion(cc) : cc
    end
    criteria.each do |ac|
      AddAcceptanceCriterionUsecase.perform(issue.id, ac)
    end
  end

  def add_issue_to_release(issue_id, release_id)
    AddReleaseItemUsecase.perform(issue_id, release_id)
  end

  def estimate_feature(issue_id, size)
    EstimateFeatureUsecase.perform(issue_id, Issue::StoryPoint.new(size))
  end

  def start_issue_development(issue_id)
    StartIssueDevelopmentUsecase.perform(issue_id)
  end

  def remove_issue(issue_id)
    RemoveIssueUsecase.perform(issue_id)
  end

  def add_release(product_id, title = 'Release2')
    AddReleaseUsecase.perform(product_id, title)
      .yield_self { |id| ReleaseRepository::AR.find_by_id(id) }
  end

  private

  def perform_add_issue(product_id, desc)
    Issue::Description.new(desc)
      .yield_self { |d| AddIssueUsecase.perform(product_id, d) }
      .yield_self { |id| IssueRepository::AR.find_by_id(id) }
  end
end

RSpec.configure do |c|
  c.include IssueSupport
end
