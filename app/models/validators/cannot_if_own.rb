class Validators::CannotIfOwn < ActiveModel::Validator

  def validate(record)
    unless record.user != record.idea.user
      record.errors[:user_id] << "You can't perform this task on your own idea"
      #{record.class.name}!"
      # record.idea.errors[:user_id] << "You can't like your own idea!"
    end
  end

end