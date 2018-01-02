class LibraryRecordsController < SessionsController

    before_action :user_logged

    def show
      unless record_exist
        @record = LibraryRecord.new(book_id: params[:id], user_id: @user_logged.id)
        @record.save
      end
      redirect_to books_path
    end

    def destroy
      @record = record_exist
      #unless @record.created_at.to_date.eql? DateTime.now.to_date
        @record.update(returned: true)
      #end
      redirect_to books_path
    end

    def record_exist
      record = LibraryRecord.find_by(book_id: params[:id], user_id: @user_logged.id, returned: false)
    end
  end