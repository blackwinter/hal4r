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

end
