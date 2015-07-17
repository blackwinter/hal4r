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

require 'forwardable'
require 'gsl'

class Hal4R

  class Matrix

    include Enumerable

    extend Forwardable

    DEFAULT_STEP = 512

    def_delegator :@matrix, :size1, :size

    def initialize(step = nil)
      @matrix = matrix(@step = step || DEFAULT_STEP)
    end

    attr_accessor :step

    def get(index)
      expand unless index < size
      @matrix.row(index)
    end

    def vector(index, size = size(), norm = false)
      vector = @matrix.subrow(index, 0, size)
        .concat(@matrix.subcolumn(index, 0, size))

      Vector.new(norm ? vector.to_f.normalize : vector)
    end

    def each_col(&block)
      block ? @matrix.each_col(&block) : enum_for(:each_col)
    end

    def inspect
      '#<%s:0x%x @step=%p, @size=%p>' % [
        self.class, object_id, step, size
      ]
    end

    private

    def expand(new_size = size + step)
      @matrix = matrix(new_size).set(range = 0 .. size - 1, range, @matrix)
    end

    def matrix(size)
      GSL::Matrix::Int.zeros(size)
    end

  end

end
