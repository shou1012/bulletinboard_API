module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]
    before_action :set_user, only: [:update, :destroy, :show]
    
    def show
      render json: @user
    end

    def create
      @user = User.new user_params

      if @user.save!
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user
      else
        render json: { error: t('user_update_error') }, status: :unprocessable_entity
      end
    end

    def destroy
      if @user.destroy
        head :no_content
      else
        render json: { error: t('user_delete_error') }, status: :unprocessable_entity
      end
    end

    private
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render status: :not_found, json: { errors: "User not found" }
      end
    end
  end
end
