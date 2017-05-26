class AttestationsController < ApplicationController
  def index
    @attestations = Attestation.all.page(params[:page])
  end

  def show
    @attestation = Attestation.find(params[:id])
  end
end