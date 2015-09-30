
  # Return fqdn for keymanager hosts if present
  # @return [Array]
  def keydaemon_hosts(clusters)
    clusters
      .select { |cluster| cluster.key?(:ckeymanager) }
      .map { |cluster| cluster[:ckeymanager] }
      .flatten
      .map { |host| host['fqdn'] }
  end

  # @param[Hash] front_domains
  # @return [Hash]
  def ssl_certs_for_domain(front_domains)
    res = {}
    front_domains.each_key do |domain|
      res[domain] = yield(domain)
    end
    res
  end

