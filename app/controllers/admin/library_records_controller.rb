class Admin::LibraryRecordsController < Admin::SessionsController
  before_action :user_logged

  def index
    if params[:filter].eql? "borrowed"
      @records = LibraryRecord.includes(:book).where(returned: false)
    elsif params[:filter].eql? "returned"
      @records = LibraryRecord.includes(:book).where(returned: true)
    else
      @records = LibraryRecord.includes(:book).all
    end
  end

end