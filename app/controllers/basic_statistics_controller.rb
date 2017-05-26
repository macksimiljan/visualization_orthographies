class BasicStatisticsController < ApplicationController
  def index
    @tree = "{\"name\": \"root\", \"children\": [
                {\"name\": \"child 1\", \"children\": [
                  {\"name\": \"grandchild 1\", \"children\":[]}
                ]},
                {\"name\": \"child 2\", \"children\": []}
              ]}"
    @tree = [1, 2]
    respond_to do |format|
      format.html
      format.json{ render json: @tree }
    end
  end
end