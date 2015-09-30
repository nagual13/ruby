gem 'minitest'
require 'minitest/autorun'

class LearningTest < Minitest::Test

  def setup
    @servers = [
        {
            :id => 1,
            :model => 'R530',
            :cpu => [{:cores => 8, :frequency => 2.5}],
            :ram => [16, 16, 16, 16],
            :storage => [{:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}]
        },
        {
            :id => 2,
            :model => 'R530',
            :cpu => [{:cores => 8, :frequency => 2.8}],
            :ram => [16, 16, 16, 16, 16, 16, 16, 16],
            :storage => [{:type => :sas, :size => 600}, {:type => :sas, :size => 600}]
        },
        {
            :id => 3,
            :model => 'R530',
            :cpu => [{:cores => 8, :frequency => 2.3}],
            :ram => [16, 16, 16, 16, 16, 16, 16, 16],
            :storage => [{:type => :sas, :size => 600}, {:type => :sas, :size => 600}, {:type => :ssd, :size => 400}, {:type => :ssd, :size => 400}]
        }
    ]
  end
    # TODO Sasha
   def find_ids_with_ram_over_100 (servers)
    ids_with_ram_over_100=[]
    ids=1
    servers.each do |item|
      ram = item[:ram]
      ids = item[:id]
      count_of_memory_pl= ram.size
      puts count_of_memory_pl
      if count_of_memory_pl*16>100 then ids_with_ram_over_100.push(ids)
      end

    end

  ids_with_ram_over_100
   end

  def test_find_ids_with_ram_over_100
    assert_equal [2, 3], find_ids_with_ram_over_100(@servers)
  end

end