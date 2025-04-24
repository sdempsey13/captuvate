class DomainUploadJob < ApplicationJob
  require 'csv'
  queue_as :default

  def perform(blob_id, user_id)
    blob = ActiveStorage::Blob.find(blob_id)
    user = User.find(user_id)
    
    blob.open do |file|
      CSV.foreach(file.path, headers: true) do |row|
        dom = Domain.new(
          url: row['URL'],
          user_id: user_id,
          name: row['Name'],
          domain_schedule_attributes: {
            frequency: row['Frequency']
          }
        )

        dom.save!
      end
    end
  end
end
  