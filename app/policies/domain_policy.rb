class DomainPolicy < ApplicationPolicy
  def show?
    owner_or_admin?
  end

  def show_desktop?
    owner_or_admin?
  end

  def show_mobile?
    owner_or_admin?
  end

  def edit?
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  private

  def owner_or_admin?
    record.user_id == user.id || user.admin?
  end
end
