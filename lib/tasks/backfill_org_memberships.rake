# lib/tasks/backfill_organization_memberships.rake
namespace :backfill do
  desc "Create organization memberships for all existing users"
  task organization_memberships: :environment do
    count = 0

    User.where(organization_id: nil).find_each do |user|
      user.update_column(:organization_id, 5)
    end

    User.where.not(organization_id: nil).find_each do |user|
    OrganizationMembership.find_or_create_by!(
      user_id: user.id,
      organization_id: user.organization_id
    ) do |membership|
      membership.role = 1
    end

    user.update_column(:organization_id, nil)
    count += 1
    end
    puts "✅ Backfilled #{count} organization memberships"
  end
end
  