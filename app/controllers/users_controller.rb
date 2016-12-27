class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # @users = User.includes(:addresses).where("addresses.active"=>true)
    @users = User.includes(:addresses).where("addresses.active" => true)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @addresses = []
    5.times do
      @addresses << Address.new
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @addresses = @user.addresses
  end

  # POST /users
  # POST /users.json
  def create
    user_and_addresses = user_params 
    user_and_addresses[:addresses_attributes].reject! { |key| user_and_addresses[:addresses_attributes][key]["desc"]==""}
    @user = User.new(user_and_addresses)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user.addresses.destroy_all
    user_and_addresses = user_params 
    user_and_addresses[:addresses_attributes].reject! { |key| user_and_addresses[:addresses_attributes][key]["desc"]==""}
    respond_to do |format|
      if @user.update(user_and_addresses)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name,:addresses_attributes => [:desc,:active])
  end
end
