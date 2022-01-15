module Mod
  module A
    def message
      "A"
    end
  end

  module B
    def message
      "B#{super}B"
    end
  end

  module C
    def message
      "C#{super}C"
    end
  end

  include A
  include B
  include C
end

class Klass
  include Mod
end

p Klass.ancestors
#=> [Klass, Mod, Mod::C, Mod::B, Mod::A, Object, Kernel, BasicObject]

p Klass.new.message
#=> "CBABC"

Mod::A.module_eval do
  def message
    "O"
  end
end

p Klass.new.message
#=> "CBOC"

module Patch
  def message
    "X"
  end
end

Mod::A.prepend(Patch)

p Klass.ancestors
# ruby >= 3.0
#=> [Klass, Mod, Mod::C, Mod::B, Patch, Mod::A, Object, Kernel, BasicObject]
# otherwise
#=> [Klass, Mod, Mod::C, Mod::B, Mod::A, Object, Kernel, BasicObject]

p Klass.new.message
# ruby >= 3.0
#=> "CBXBC"
# otherwise
#=> "CBOBC"
