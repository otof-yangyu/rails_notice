class Notice::Admin::NotificationSettingsController < Notice::Admin::BaseController
  before_action :set_notification_setting, only: [:show, :edit, :update, :destroy]

  def index
    q_params = params.fetch(:q, {}).permit(:id, :receiver_type, :receiver_id)
    @notification_settings = NotificationSetting.default_where(q_params).page(params[:page])
  end

  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = NotificationSetting.new(notification_setting_params)

    if @notification_setting.save
      redirect_to admin_notification_settings_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @notification_setting.update(notification_setting_params)
        format.html { redirect_to admin_notification_settings_url }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @notification_setting.destroy
    redirect_to admin_notification_settings_url
  end

  private
  def set_notification_setting
    @notification_setting = NotificationSetting.find(params[:id])
  end

  def notification_setting_params
    params.fetch(:notification_setting, {}).permit(
      :showtime,
      :accept_email,
      notifiable_types: []
    )
  end

end
