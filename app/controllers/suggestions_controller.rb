class SuggestionsController < ApplicationController
  def destroy
    Suggestion.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to moderate_url, notice: 'Suggestion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def create
    @suggestion = Suggestion.new(suggestion_params)
    @suggestion.user_id = current_user.id
    @post = Post.find params[:suggestion][:post_id]

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to @post, notice: 'Your suggestion will be moderated soon!' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to @post, alert: 'Your suggestion is not valid' }
        format.json { render json: @suggestion.errors, status: :unprocessable_entity }
      end
    end
  end

  private 

  def suggestion_params
    params.require(:suggestion).permit(:artist_id, :post_id)
  end

end
