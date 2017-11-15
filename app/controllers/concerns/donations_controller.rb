class DonationsController < ApplicationController

  def create
    @donation = Donation.new(donation_params)
    @donation_type = DonationType.find_or_create_by(type_name: params[:type_name])
    @item = Item.new(donation_type: @donation_type)
    @item.save
    @donation.item_id = @item.id

    if @donation.save
      render json: {donation: @donation, donation_type: @donation_type}
    else
      render json: {errors: @donation.errors.full_messages}, status: 422
    end
  end

  def update
    @donation = Donation.find_by(id: params[:id])

    if @donation.update(donation_params)
      render json: @donation
    else
      render json: {errors: @donation.errors.full_messages}, status: 422
    end
  end

  private

  def donation_params
    params.require(:donation).permit(:quantity_requested, :quantity_received, :project_id)
  end

end