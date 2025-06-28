class SnapShotPolicy < ApplicationPolicy
  def show?
    owner_or_admin?
  end
  
  def show_html?
    owner_or_admin?
  end

  private
  
  def owner_or_admin?
    record.domain.user_id == user.id || user.site_admin?
  end
end
