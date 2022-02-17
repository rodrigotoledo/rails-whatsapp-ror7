module MessagesHelper
  def users_except_current
    User.where("id != ?", current_user.id)
  end
end
