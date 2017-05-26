class MorphoSyntaxesController < ApplicationController
  def index
    @morpho_syntaxes = MorphoSyntax.all.page(params[:page])
  end

  def show
    @morpho_syntax = MorphoSyntax.find(params[:id])
  end
end