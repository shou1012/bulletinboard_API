module V1
  class RoomsController < ApplicationController
    before_action :set_room, only: [:update, :show, :destroy]

    def index
      @rooms = Room.all
      render :json => @rooms
      # render 'index', formats: 'json', handlers: 'jbuilder'
    end

    def show
      render :json => @room
     end

    def create
      p current_user
      @room = Room.new(room_params)
      @room.user_id = current_user.id
      if @room.save
        render json: @room, status: :created
      else
       render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }
      end
    end

    def update
      if @room.update(room_params)
        render json: @room, status: :updated
      else
        render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }
      end
    end

    def destroy
        if @room.destroy
          head :no_content
        else
          render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }
        end
    end

    private
      def room_params
        params.require(:room).permit(:name, :description)
      end

      def set_room
        begin
          @room = Room.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render status: :not_found, json: { errors: "Data not found" }
        end
      end
  end
end
