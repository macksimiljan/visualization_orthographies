class GreekLemmasController < ApplicationController
  def index
    @greek_lemmas = GreekLemma.order(:label).page(params[:page])
  end

  def show
    @greek_lemma = GreekLemma.find(params[:id])
  end
end