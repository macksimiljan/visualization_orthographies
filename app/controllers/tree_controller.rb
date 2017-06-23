class TreeController < ApplicationController
  def index
    puts "glid:#{params[:greek_lemma_id]}"
    if params.include? :greek_lemma_id
      lemma_id = params[:greek_lemma_id].nil? ? 3 :params[:greek_lemma_id].first
      puts params[:greek_lemma_id]
      @tree = Tree.new.fetch(params[:greek_lemma_id])

      respond_to do |format|
        format.html
        format.json { render json: @tree }
      end
    end
  end
end
