class BatchController < ApplicationController
  def index
  	@batches = Batch.all
  end

  def show
  end

  def export
    @batch = Batch.find(params[:id])
    filename = "Batch_#{Date.today.strftime('%d%b%y')}"
    csv_data = CSV.generate do |csv|
      csv << @batch.csv_header
      @batch.sites.each do |c|
        row = [c.url, c.is_valid?, c.is_business?]
        csv << row
      end
    end
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end
end
