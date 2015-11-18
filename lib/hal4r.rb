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
require 'nuggets/hash/idmap'

class Hal4R

  include Enumerable

  extend Forwardable

  DEFAULT_WINDOW_SIZE = 10

  def_delegator :@idmap, :keys, :terms

  def_delegators :@idmap, :size, :empty?

  def initialize(terms = [], window_size = nil)
    reset(window_size)
    add(terms)
  end

  attr_accessor :window_size

  def reset(window_size = window_size())
    @idmap, @matrix, @window = Hash.idmap(-1), Matrix.new,
      Array.new(@window_size = window_size || DEFAULT_WINDOW_SIZE)

    #@geometric_factor = @window_size * 2 ** -@window_size

    self
  end

  def <<(term)
    row = @matrix.get(term_key = @idmap[term])

    # NOTE: only records "before" window,
    # "after" window is redundant (falls
    # out of the matrix automatically),
    # *unless* asymmetric weighting is
    # desired -- is it worth the trouble?
    @window.each_with_index { |key, index|
      row[key] += weight(index + 1) if key
    }.insert(-1, term_key).shift

    self
  end

  def add(terms)
    terms.each { |term| self << term }
    self
  end

  def vector(term, norm = false)
    vector_i(@idmap.fetch(term), norm)
  end

  alias_method :[], :vector

  def norm(term)
    vector(term, true)
  end

  def each_vector(norm = false)
    return enum_for(__method__, norm) unless block_given?

    @idmap.each_value { |key| yield vector_i(key, norm).to_a }

    self
  end

  def each_norm(&block)
    each_vector(true, &block)
  end

  alias_method :each, :each_norm

  def each_distance(norm = true, dimension = 2)
    return enum_for(__method__, norm, dimension) unless block_given?

    terms.combination(2) { |t| yield *t.sort!, minkowski(*t, dimension, norm) }

    self
  end

  def related(term, num = window_size, dimension = 2)
    (terms - [term]).sort_by { |t| minkowski(term, t, dimension) }.first(num)
  end

  def minkowski(term1, term2, dimension, norm = true)
    vector(term1, norm).minkowski(vector(term2, norm), dimension)
  end

  alias_method :distance, :minkowski

  def euclidean(term1, term2, norm = true)
    minkowski(term1, term2, 2, norm)
  end

  def manhattan(term1, term2, norm = true)
    minkowski(term1, term2, 1, norm)
  end

  alias_method :cityblock, :manhattan

  def to_a(norm = true)
    norm ? each_norm.to_a : each_vector.to_a
  end

  def to_s
    cols = [terms.unshift(nil)]

    @matrix.each_col.with_index { |col, key|
      cols << [@idmap.key(key), *col] unless col.isnull? }

    fmt = cols.map { |col|
      "%#{col.map { |val| val.to_s.length }.max}s" }.join(' ') << $/

    cols.first.each_index.map { |key|
      fmt % cols.map { |col| col[key] } }.join
  end

  def inspect
    '#<%s:0x%x @window_size=%p, @size=%p>' % [
      self.class, object_id, window_size, size
    ]
  end

  private

  def even_weight(window_position)
    1
  end

  # requires GSL::Matrix instead of GSL::Matrix::Int
  #def geometric_weight(window_position)
  #  @geometric_factor * 2 ** window_position
  #end

  def linear_weight(window_position)
    window_position
  end

  alias_method :weight, :linear_weight

  def vector_i(key, norm)
    @matrix.vector(key, size, norm)
  end

end

require_relative 'hal4r/matrix'
require_relative 'hal4r/vector'
require_relative 'hal4r/version'
