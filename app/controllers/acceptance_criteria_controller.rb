class AcceptanceCriteriaController < ApplicationController

  def create
    pbi_id = Pbi::ItemId.from_string(params[:product_backlog_item_id])
    AddAcceptanceCriterionUsecase.new.perform(pbi_id, params[:form][:content])
    redirect_to edit_product_backlog_item_path(id: pbi_id.to_s)
  end

  def destroy
    pbi_id = Pbi::ItemId.from_string(params[:product_backlog_item_id])
    RemoveAcceptanceCriterionUsecase.new.perform(pbi_id, params[:no].to_i)
    redirect_to edit_product_backlog_item_path(id: pbi_id.to_s)
  end
end
