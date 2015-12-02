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
    if OriginalDataFile.upload_odf(params[:original_data_file][:data], params[:odt_id])
      flash[:notice] = "Successfully updated!"
    else
      flash[:warning] = "Something went wrong! Please try again."
    end
      redirect_to :controller => 'original_data_type', :action => 'index', :task_id => params[:task_id]
  end

  def destroy
    @odf = OriginalDataFile.find(params[:id])
    @odf.destroy
    redirect_to :action => 'show'
    
  end

  
end
