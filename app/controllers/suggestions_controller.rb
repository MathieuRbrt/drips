class SuggestionsController < ApplicationController
  def destroy
    Suggestion.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to moderate_url, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
