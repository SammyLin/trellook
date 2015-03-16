class ActionsController < ApplicationController
  def read
    action = Action.find_or_create_by(:action_id => params[:id])
    action.read_state = true
  end

  def unread
    action = Action.find_or_create_by(:action_id => params[:id])
    action.read_state = false
  end
end
