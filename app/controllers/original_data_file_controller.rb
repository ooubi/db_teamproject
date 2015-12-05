class OriginalDataFileController < ApplicationController
  def new
  end

  def show
    @all_odfs = OriginalDataFile.all
    respond_to do |format|
      format.html
    end
  end

  def show_file
  	@odf = OriginalDataFile.find(params[:id])
    @content = [@odf.file].pack("b*")
  	respond_to do |format|
  		format.html
  	end
  end

  def upload
    odf_params = params[:original_data_file]
    if odf_params[:data] != nil &&
        OriginalDataFile.upload_odf(odf_params[:data], odf_params[:odt_id],
          current_user.user_id, odf_params[:task_id], odf_params[:season_info], odf_params[:period_info])
      flash[:notice] = "Successfully updated!"
    else
      flash[:warning] = "Something went wrong! Please try again."
    end
    redirect_to :controller => 'original_data_type', :action => 'index', :task_id => odf_params[:task_id]
  end

  def destroy
    @odf = OriginalDataFile.find(params[:id])
    @odf.destroy
    redirect_to :action => 'show'
    
  end

  
end
