module DomainsHelper
  def domain_idntifier(domain)
    domain.name || domain.url.truncate(27)
  end
end