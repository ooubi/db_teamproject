class ConsentFormController < ApplicationController
  def show
  	datas = "Consent Form for Task"
    send_data( datas, :filename => "consent_form.txt" )
  end
end
