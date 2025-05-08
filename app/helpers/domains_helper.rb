module DomainsHelper
  def domain_identifier(domain)
    domain.name || domain.url.truncate(27)
  end
end