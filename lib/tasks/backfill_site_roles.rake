# lib/tasks/backfill_organization_memberships.rake
namespace :backfill do
  desc "Set all users without site role to client"
  task site_roles: :environment do
    User.left_joins(:site_role).where(site_role: { id: nil }).find_each do |user|
      SiteRole.find_or_create_by!(
        user_id: user.id,
        role: 1
      )
    end
  end
end
  