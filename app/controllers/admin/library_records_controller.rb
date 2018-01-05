class Admin::LibraryRecordsController < Admin::SessionsController
  before_action :user_logged

  def index
    @records = LibraryRecord.all
  end

end