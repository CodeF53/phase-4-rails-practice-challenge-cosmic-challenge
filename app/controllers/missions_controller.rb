class MissionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def create
    mission = Mission.create!(mission_params)
    render json: mission.planet, status: :created
  end


  private

  def mission_params
    params.permit(:name, :scientist_id, :planet_id)
  end

  def render_not_found_response
    render json: { error: 'Mission not found' }, status: :not_found
  end
  
  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
