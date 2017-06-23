class SourcesController < ApplicationController
  def index
    @sources =
      if params[:ids].nil?
        Source.all.page(params[:page])
      else
        Source.where("id in (#{params[:ids][1...-1]})").page(params[:page])
      end
  end

  def show
    @source = Source.find(params[:id])
  end
end