class Api::ManageController < Api::BaseController
  def auth
    platform_id = params[:platform_id]
    device_id = params[:device_id]
    if platform_id == nil || device_id == nil
      render json: { code: "-1" }
      return
    end
    #validate
    render json: { code: "0"}
  end

  def shot
    platform_id = params[:platform_id]
    device_id = params[:device_id]
    dir = "public/shots/#{platform_id}/#{device_id}"
    if !File.directory?(dir)
      FileUtils.mkdir_p(dir)
    end
    file_name = File.join(dir, "screen.png")
    #multipart
    uploaded_io = params[:picture]
    uploaded_io.rewind
    File.open(file_name, "wb") do |file|
      file.write(uploaded_io.read)
    end
    render json: { code: "0"}
  end
end
