require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

class SymptomsController < ApplicationController
  CALENDAR_ID = 'primary'


  def new
    @symptom = Symptom.new
    render :show_form
  end

  def create
    client = get_google_calendar_client current_user
    symptom = params[:symptom]
    title = get_title symptom
    client.insert_event('primary', title)
    flash[:notice] = 'Symptom was successfully added.'
    #redirect_to symptoms_path
    @symptom = Symptom.create(symptom_params)
    save_symptom
  end

  def get_google_calendar_client current_user
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)
    secrets = Google::APIClient::ClientSecrets.new({
                                                     "web" => {
                                                       "access_token" => current_user.access_token,
                                                       "refresh_token" => current_user.refresh_token,
                                                       "client_id" => ENV["GOOGLE_API_KEY"],
                                                       "client_secret" => ENV["GOOGLE_API_SECRET"]
                                                     }
                                                   })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if !current_user.present?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      flash[:error] = 'Your token has been expired. Please login again with google.'
      redirect_to :back
    end
    client
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    @symptom.destroy
    @symptoms = Symptom.all
  end

  def edit
    @symptom = Symptom.find(params[:id])
    render :show_form
  end

  def update
    @symptom = Symptom.find(params[:id])
    @symptom.update(symptom_params)
    save_symptom
  end

  private

  def get_event symptom
    #attendees = symptom[:members].split(',').map{ |t| {email: t.strip} }
    event = Google::Apis::CalendarV3::Event.new({
                                                  summary: symptom[:title],
                                                  location: '800 Howard St., San Francisco, CA 94103',
                                                  description: symptom[:note],
                                                  start: {
                                                    date: symptom[:date]
                                                  },
                                                  end: {
                                                    date: symptom[:date]
                                                  },
                                                  attendees: "",
                                                  reminders: {
                                                    use_default: false,
                                                    overrides: [
                                                      Google::Apis::CalendarV3::EventReminder.new(reminder_method:"popup", minutes: 10),
                                                      Google::Apis::CalendarV3::EventReminder.new(reminder_method:"email", minutes: 20)
                                                    ]
                                                  },
                                                  notification_settings: {
                                                    notifications: [
                                                      {type: 'event_creation', method: 'email'},
                                                      {type: 'event_change', method: 'email'},
                                                      {type: 'event_cancellation', method: 'email'},
                                                      {type: 'event_response', method: 'email'}
                                                    ]
                                                  }, 'primary': true
                                                })
  end

  def save_symptom
    if @symptom.save
      @symptoms = Symptom.all
      render :hide_form
    else
      render :show_form
    end
  end

  def symptom_params
    params.require(:symptom).permit(:title, :note, :date, :rating)
  end
end
