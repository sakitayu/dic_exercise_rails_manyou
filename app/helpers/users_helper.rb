module UsersHelper
  def number_of_tasks(user)
    number_of_tasks = Task.where(user_id: user.id).includes(:user)
    number_of_tasks.count
  end
end
