class VwoCampaignIngestorService
  def initialize(json_data, integration_credential)
    @data = json_data
    @integration_credential = integration_credential
  end

  def ingest!
    rows = collect_rows
    upsert_rows(rows)
  end

  private

  def collect_rows
    @data.map do |campaign|
      {
        name:                 campaign["name"],
        integration_id:       @integration_credential.integration.id,
        organization_id:      @integration_credential.organization.id,
        external_id:          campaign["id"],
        status:               campaign["status"],
        campaign_created_at:  Time.at(campaign["createdOn"]),
        campaigns_metadata:   campaign
      }
    end
  end

  def upsert_rows(rows)
    Campaign.upsert_all(rows, unique_by: :index_campaigns_on_external_platform_org)
  end
end