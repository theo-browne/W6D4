require 'byebug'

class UsersController < ApplicationController

    def index
      # debugger
      if params[:username]
        user = User.find_by(username: params[:username])
      else
        user = User.all
      end 

      render json: user
    end

    def create
      # render json: params
      user = User.new(user_params)
      if user.save
        render json: user
      else
        render json: user.errors.full_messages, status: 422
      end
    end 

    def show 
      user = User.find(params[:id])

      render json: user
    end

    def update
      user = User.find(params[:id])

      if user.update(user_params)
        render json: user
      else
        render json: user.errors.full_messages, status: 422
      end
    end

    def destroy
      user = User.find(params[:id])

      user.destroy
      render json: user
    end

    def favorites
      

      favorites = Artwork.joins(:shared_viewers).where("artwork_shares.viewer_id = #{params[:id]}").where(artwork_shares: {favorite?: true})

      render json: favorites

    end
# .select("artworks.*")
    private

    def user_params
      params.require(:user).permit(:username)
    end

end
