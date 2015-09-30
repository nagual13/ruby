require 'minitest/autorun'
require_relative '../../cookbooks/paymantix/libraries/helpers'

class HelperTest < Minitest::Test

  def test_no_clusters_with_keyserver
    clusters = [
        {:cclient => [] }
    ]

    assert_equal [], keydaemon_hosts(clusters)
  end

  def test_no_hosts_in_cluster
    clusters = [
        {:ckeymanager => [] }
    ]

    assert_equal [], keydaemon_hosts(clusters)
  end

  def test_multiple_hosts
    clusters = [
        {:cclient => []},
        {:ckeymanager => [ {'fqdn' => 'kmg01.pm.lux'}, {'fqdn' => 'kmg02.pm.lux'}] }
    ]

    expectation = ['kmg01.pm.lux', 'kmg02.pm.lux']

    assert_equal expectation, keydaemon_hosts(clusters)
  end
end