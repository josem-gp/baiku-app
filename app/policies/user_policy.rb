class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    record == user
  end

  def update?
    record == user
  end

  def profile?
    record == user
  end
end
