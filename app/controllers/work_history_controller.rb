class WorkHistoryController < ApplicationController
  def create
    file = params[:csv_file]
    result = file_service.save file

    if result[:success]
      redirect_to work_history_path id: file.original_filename
    else
      redirect_to new_work_history_path, alert: result[:message]
    end
  end

  def show
    render_not_found unless file_service.exist? params[:id]

    @results = work_history_service.process file_service.file_path params[:id]
  end

  private
  def work_history_service
    @work_history_service ||= WorkHistoryService.new
  end

  private
  def file_service
    @file_service ||= FileService.new
  end
end
