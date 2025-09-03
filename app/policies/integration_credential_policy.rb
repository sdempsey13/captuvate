class IntegrationCredentialPolicy < ApplicationPolicy
  def index?
    admin_or_owner?
  end

  def create?
    admin_or_owner?
  end

  def destroy?
    admin_or_owner?
  end

  private

  def admin_or_owner?
    user.site_admin? ||
    user.organization_roles.any? { |r| r.organization_id == user.current_organization_id && r.role == "admin" }
  end
end
  