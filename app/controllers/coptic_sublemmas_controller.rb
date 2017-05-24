class CopticSublemmasController < ApplicationController
  def index
    @coptic_sublemmas = CopticSublemma.all.page(params[:page])
  end

  def show
    @coptic_sublemma = CopticSublemma.find(params[:id])
  end
end