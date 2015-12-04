class ImplementOdtController < ApplicationController

  # TODO : ODT에 대해서
  # 전체 제출된 파일 수 = @pdsfs.size 와 pass되어 태스크 데이터 테이 블에 저장된 tuple 수를 확인할 수 있다.
  def show
  	@odt = OriginalDataType.find_by(:odt_id => params[:odt_id])
  	@pdsfs = ImplementOdt.get_pdsfs(params[:odt_id])
  	@pdsf_num = @pdsfs.size
  	@tuple_num = ImplementTask.get_odt_tuple_num(params[:odt_id])
  end

  def index
  	@odt = OriginalDataType.find_by(:odt_id => params[:odt_id])
  	@my_pdsfs = ImplementOdt.get_my_pdsfs(params[:odt_id], params[:user_id])
  end
end
