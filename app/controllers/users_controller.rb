class UsersController < ManagerController
  before_action :authenticate_account!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /userrs
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /userrs/1
  def show
  end

  # GET /userrs/new
  def new
    @user = User.new
  end

  # GET /userrs/1/edit
  def edit
  end

  # POST /userrs
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /userrs/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /userrs/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:device_id, :nickname, :level, :score_single, :score_single, :score_0_online, :score_1_online, :score_2_online, :try_challenge, :win_challenge, :challenge_request, :challenge_result)
    end
end
