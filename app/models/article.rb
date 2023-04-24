class Article < ApplicationRecord
  after_update_commit(lambda do
    broadcast_replace_to(
      "some-id",
      target: 'some-target',
      locals: {
        current_user: User.last
      }
    )
  end)
end
