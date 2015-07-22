describe Hal4R do

  terms = %w[the horse raced past the barn fell .]

  subject { described_class.new(terms, 5) }

  delta = Float::EPSILON

  example do
    expect(subject.to_a(false)).to eq([
      [2, 3, 4, 5, 0, 0, 0, 2, 5, 4, 3, 6, 4, 3],
      [5, 0, 0, 0, 0, 0, 0, 3, 0, 5, 4, 2, 1, 0],
      [4, 5, 0, 0, 0, 0, 0, 4, 0, 0, 5, 3, 2, 1],
      [3, 4, 5, 0, 0, 0, 0, 5, 0, 0, 0, 4, 3, 2],
      [6, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 5, 4],
      [4, 1, 2, 3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 5],
      [3, 0, 1, 2, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0]
    ])
  end

  example do
    expect(subject.to_s).to eq(<<-EOT)
      the horse raced past barn fell
  the   2     3     4    5    0    0
horse   5     0     0    0    0    0
raced   4     5     0    0    0    0
 past   3     4     5    0    0    0
 barn   6     2     3    4    0    0
 fell   4     1     2    3    5    0
    .   3     0     1    2    4    5
    EOT
  end

  example do
    expect(subject.euclidean('horse', 'barn')).to be_within(delta).of(1.1134848787319154)
  end

  example do
    expect(subject.manhattan('horse', 'barn')).to be_within(delta).of(3.2255132606573502)
  end

  ary = [
    ['horse', 'the',   Float],
    ['raced', 'the',   Float],
    ['past',  'the',   Float],
    ['barn',  'the',   Float],
    ['fell',  'the',   Float],
    ['.',     'the',   Float],
    ['horse', 'raced', Float],
    ['horse', 'past',  Float],
    ['barn',  'horse', Float],
    ['fell',  'horse', Float],
    ['.',     'horse', Float],
    ['past',  'raced', Float],
    ['barn',  'raced', Float],
    ['fell',  'raced', Float],
    ['.',     'raced', Float],
    ['barn',  'past',  Float],
    ['fell',  'past',  Float],
    ['.',     'past',  Float],
    ['barn',  'fell',  Float],
    ['.',     'barn',  Float],
    ['.',     'fell',  Float]
  ]

  example do
    expect(subject.each_distance.to_a).to match(ary)
  end

  example do
    expect{|b|subject.each_distance(&b)}.to yield_successive_args(*ary)
  end

  example do
    expect(subject.each_distance(false).to_a).to match(ary)
  end

  example do
    expect{|b|subject.each_distance(false, &b)}.to yield_successive_args(*ary)
  end

  example do
    expect(subject.each_distance(true, 1).to_a).to match(ary)
  end

  example do
    expect{|b|subject.each_distance(true, 1, &b)}.to yield_successive_args(*ary)
  end

end
