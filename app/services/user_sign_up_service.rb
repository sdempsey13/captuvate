class UserSignUpService
  def initialize(user_params)
    @user_params = user_params.deep_dup
  end

  def call
    org_attrs = @user_params.delete(:organization_attributes)
    raise ArgumentError, 'Missing organization attributes' unless org_attrs.present?

    User.transaction do
      organization = Organization.create!(org_attrs)
      user = User.create!(@user_params)

      OrganizationMembership.create!(
        user: user,
        organization: organization,
        role: :admin
      )

      workspace = organization.workspaces.create!(name: 'Default Workspace')

      WorkspaceMembership.create!(
        user: user,
        workspace: workspace,
        role: :admin
      )
      
      user
    end
  end
end
  