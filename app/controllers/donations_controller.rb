class DonationsController < ApplicationController

  def create
    @donation = Donation.new(donation_params)
    @donation_type = DonationType.find_or_create_by(type_name: params[:donation_type])

    @item = Item.new(
      donation_type: @donation_type,
      item_name: params[:item_name]
    )
    @item.save
    @donation.item_id = @item.id

    if @donation.save
      render json: {donation: @donation, donation_type: @donation_type, item: @item}
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

  def destroy
    @donation = Donation.find_by(id: params[:id])
    @project = @donation.project
    @donation.destroy
    @donations = @project.donations
    donations_hash = @donations.map do |donation|
      {
        id: donation.id,
        donation_type: donation.donation_type,
        item: donation.item.item_name,
        quantity_received: donation.quantity_received,
        quantity_requested: donation.quantity_requested
      }
    end

    render json: donations_hash, status: 200
  end

  private

  def donation_params
    params.require(:donation).permit(:quantity_requested, :quantity_received, :project_id)
  end

end