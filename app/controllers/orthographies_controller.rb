class OrthographiesController < ApplicationController
  def index
    @orthographies = Orthography.all.order(:coptic_sublemma_id).page(params[:page])
  end

  def show
    @orthography = Orthography.find(params[:id])
  end
end