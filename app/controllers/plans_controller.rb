# typed: false
class PlansController < ApplicationController
  include ProductHelper
  include TeamMemberHelper

  def update
    product_id = Product::Id.from_string(current_product_id)
    roles = current_team_member_roles
    issue_id = Issue::Id.from_string(params[:issue_id])
    to_index = params[:to_index].to_i
    to = params[:to].to_i
    from = params[:from].to_i

    if from == to
      ChangeIssuePriorityUsecase.perform(product_id, roles, issue_id, to_index)
    else
      RescheduleIssueUsecase.perform(product_id, roles, issue_id, to, to_index)
    end
  end

  private

  def current_product_id
    params[:product_id]
  end
end
