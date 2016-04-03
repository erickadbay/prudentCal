class Event < ActiveRecord::Base
    belongs_to :course
    belongs_to :user

    def as_json(options = {})
    {
      :id => self.id,
      :title => self.title,
      :start => start_time.rfc822,
      :end => end_time.rfc822,
      :url => Rails.application.routes.url_helpers.event_path(id)
    }
    end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end
end
