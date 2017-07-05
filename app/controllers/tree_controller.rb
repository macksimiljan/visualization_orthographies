class TreeController < ApplicationController
  def index
    if params.include? :greek_lemma_id
      puts params[:greek_lemma_id]
      @tree = Tree.new.fetch(params[:greek_lemma_id])

      respond_to do |format|
        format.html
        format.json { render json: @tree }
      end
    end
  end
end
