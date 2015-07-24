#--
###############################################################################
#                                                                             #
# hal4r -- Hyperspace analogue to language for Ruby                           #
#                                                                             #
# Copyright (C) 2015 Jens Wille                                               #
#                                                                             #
# Authors:                                                                    #
#     Jens Wille <jens.wille@gmail.com>                                       #
#                                                                             #
# hal4r is free software; you can redistribute it and/or modify it under the  #
# terms of the GNU Affero General Public License as published by the Free     #
# Software Foundation; either version 3 of the License, or (at your option)   #
# any later version.                                                          #
#                                                                             #
# hal4r is distributed in the hope that it will be useful, but WITHOUT ANY    #
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS   #
# FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for     #
# more details.                                                               #
#                                                                             #
# You should have received a copy of the GNU Affero General Public License    #
# along with hal4r. If not, see <http://www.gnu.org/licenses/>.               #
#                                                                             #
###############################################################################
#++

class Hal4R

  class Vector

    include Enumerable

    def initialize(vector)
      @vector = vector
    end

    attr_reader :vector

    def each(&block)
      block ? vector.each(&block) : enum_for(:each)
    end

    def minkowski(other, dimension = 2)
      (vector - other.vector).abs.to_f.pow(dimension).sum ** 1.fdiv(dimension)
    end

    def inspect
      '#<%s:0x%x @vector=%p>' % [
        self.class, object_id, vector
      ]
    end

  end

end
