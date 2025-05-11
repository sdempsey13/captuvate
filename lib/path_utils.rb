module PathUtils
  def domain_path_generator(domain)
    if domain.collects_mobile
      domain_mobile_path(domain)
    else
      domain_desktop_path(domain)
    end
  end
end
  