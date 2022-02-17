class Message < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'
  after_create_commit -> {
    broadcast_prepend_to "messages", target: "message_container_#{self.user_id}-#{self.author_id}", partial: "messages/content_receiver", locals: {message: self}
    broadcast_prepend_to "messages", target: "message_container_#{self.author_id}-#{self.user_id}", partial: "messages/content_sender", locals: {message: self}

    broadcast_update_to "sidebar", target: "sidebar_chat_list_#{self.user_id}",  partial: 'layouts/chat', collection: self.user.users.uniq, as: :user
    broadcast_update_to "sidebar", target: "sidebar_chat_list_#{self.author_id}",  partial: 'layouts/chat', collection: self.author.users.uniq, as: :user
  }

  after_destroy_commit do
    broadcast_remove_to "messages", target: "message_container_#{self.user_id}-#{self.author_id}"
    broadcast_remove_to "messages", target: "message_container_#{self.author_id}-#{self.user_id}"

    broadcast_remove_to "sidebar", target: "sidebar_chat_list_#{self.user_id}"
    broadcast_remove_to "sidebar", target: "sidebar_chat_list_#{self.author_id}"
  end
end
