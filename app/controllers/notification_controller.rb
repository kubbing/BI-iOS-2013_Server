class NotificationController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    @notification = Notification.create
    @notification.app = 'cz.cvut.fit.bi-ios.apns'
    @notification.alert = 'Notifikace!'
    @notification.badge = 13
    @notification.sound = ""
    @notification.data = "{ \"data\" : null }"
  end
  
  def create
    @notification = Notification.create(notification_params)
    counter = 0;
    
    if @notification.token.present?
      Push::MessageApns.create(
        app: @notification.app,
        device: @notification.token,
        alert: @notification.alert,
        sound: @notification.sound,
        badge: @notification.badge,
        expiry: 1.day.to_i, 
        attributes_for_device: ActiveSupport::JSON.decode(@notification.data)
      )
      counter = counter + 1
    else
      @tokens = Account.uniq.pluck(:token)
      @tokens.each do |token|
        if token.blank?
          next
        end
      
        Push::MessageApns.create(
          app: @notification.app,
          device: token,
          alert: @notification.alert,
          sound: @notification.sound,
          badge: @notification.badge,
          expiry: 1.day.to_i, 
          attributes_for_device: ActiveSupport::JSON.decode(@notification.data)
        )
        counter = counter + 1
      end
    end
    
    respond_to do |format|
      format.html { redirect_to notification_path, notice: "#{counter} notifications enqueued" }
      format.json { render json: { notice: "#{counter} notifications enqueued", status: :created } }
    end
  end
  
  private
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def notification_params
    params.require(:notification).permit(:app, :alert, :badge, :sound, :data, :token)
  end
end
