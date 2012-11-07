class AuctionsController < ApplicationController
  skip_before_filter :authenticate_user!
  respond_to :json, :html

  def index
    @auctions = current_company.auctions
    respond_with(@auctions)
  end

  def new
    @auction = Opportunity.new
  end

  def create
    @auction = Opportunity.new(params[:opportunity])
    @auction.buyer = current_company

    if @auction.save
      redirect_to dashboard_path, :notice => "The auction has been created"
    else
      render :new
    end

  end

  def show
    @auction = Opportunity.find(params[:id])
  end

  def select_winner
    @auction = Opportunity.find(params[:id])
    @auction.win!(params[:bid_id])

    redirect_to auction_path(@auction)
  end


  private

  def current_company
    Company.first
  end
end

