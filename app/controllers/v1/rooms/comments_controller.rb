module V1
  class Rooms::CommentsController < ApplicationController
    before_action :set_room
    before_action :set_comment, only: [:update, :destroy]

    def index
      @comments = @room.comments
      render :json => @comments
    end

    def create
      @comment = Comment.new(comment_params)
      @comment.user_id = current_user.id
      @comment.room_id = @room.id
      if @comment.save
        render json: @comment, status: :created
      else
        render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }
      end
    end

    def update
      if @comment.update(comment_params)
        render json: @comment, status: :updated
      else
        render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }
      end
    end

    def destroy
      if @comment.destroy
        head :no_content
      else
        render status: :unprocessable_entity, json: { errors: "Invalid Arguments" }
      end
    end

    private
      def set_room
        @room = Room.find(params[:room_id])
      end

      def comment_params
        params.require(:comment).permit(:text)
      end

      def set_comment
        begin
          @comment = Comment.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          render status: :not_found, json: { errors: "Data not found" }
        end
      end

  end
end
