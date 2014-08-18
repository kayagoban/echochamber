module Echochamber
  class User

    # include validatable

    def initialize(params)
      # self.require([:param1, :param2], params)
      self.merge(params)
    end

end
