class MessagesController < ApplicationController
  def index
    @messages = Message.where("(user_id = ? AND author_id = ?) OR (user_id = ? AND author_id = ?)",params[:user], current_user.id, current_user.id, params[:user]).order("created_at DESC")
    @user = User.find(params[:user]) rescue nil
  end
end
