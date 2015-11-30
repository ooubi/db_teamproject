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
  	respond_to do |format|
  		format.html
  	end
  end

  def upload
	  uploaded_io = params[:original_data_file][:data]
	  csv_file = File.open(uploaded_io.tempfile, 'rb') { |file| file.read }
	  csv_file.unpack('b*') # to binary file
	  @odf = OriginalDataFile.create(file: csv_file)
		  if @odf.save
		  	flash[:notice] = "Successfully updated!"
		  	redirect_to :controller => 'task', :action => 'index'
		  end
  end

  def destroy
    @odf = OriginalDataFile.find(params[:id])
    @odf.destroy
    redirect_to :action => 'show'
    
  end

  
end
