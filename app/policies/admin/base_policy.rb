module Admin
  class BasePolicy < ApplicationPolicy

    def index?
      admin_user?
    end

    def show?
      admin_user?
    end

    def create?
      admin_user?
    end

    def update?
      admin_user?
    end

    def destroy?
      admin_user?
    end

    private

    def admin_user?
      user&.admin?
    end
  end
end
  