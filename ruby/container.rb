require 'minitest/autorun'
class Server
  def self.memory_slots(count_memory_slots, memory_type)
    define_method(:memory) do
      @memory ||= ({max: count_memory_slots, type: memory_type})
    end
  end
  def self.cpu_sockets(cpu_sockets, gen)
    define_method(:cpu) do
      @cpu ||= ({max_cpu: cpu_sockets, gen_type: gen})
    end
  end
  def << item
    if @cpu_ar.size < self.cpu[:max_cpu] and self.cpu[:gen_type] == item.cpu_ins[:gen_type]
        @cpu_ar.push(item)
    end
  end
end
class CPU
  attr_accessor :cpu_ins, :cpu_mhz, :cores, :gen_type
  def initialize(cpu_mhz, cores, gen_type)
    @cpu_mhz = cpu_mhz
    @cores = cores
    @gen_type = gen_type
    @cpu_ins = ({cpu_mhz: cpu_mhz, gen_type: gen_type, cores: cores})
  end
end
class Memory
  attr_accessor :memory_type, :memory_vol
  def initialize(memory_t, memory_vol)
    @memory_type = memory_t
    @memory_vol = memory_vol
    @memory_ins = ({memory_t: memory_t, memory_vol: memory_vol})
  end
end
class R530 < Server
  memory_slots 16, :ddr4
  cpu_sockets 2, :haswell
end

class R920 < Server
  memory_slots 32, :ddr3
  cpu_sockets 4, :ivybridge
end
class E5_4650 < CPU
  def initialize
    super 2100, 12, :haswell
  end
end

class E5_4660 < CPU
  def initialize
    super 2100, 14, :haswell
  end
end

class E5_2620 < CPU
  def initialize
    super 2100, 6, :ivybridge
  end
end
class DDR3_16 < Memory
  def initialize
    super :ddr3, 16
  end
end
class DDR4_16 < Memory
  def initialize
    super :ddr4, 16
  end
end

p server = R530.new
p m = E5_4650.new
puts server.cpu[:gen_type]
puts m.cpu_ins[:gen_type]
puts m.cpu_ins
server.cpu << m

