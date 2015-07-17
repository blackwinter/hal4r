describe Hal4R::Vector do

  vector = GSL::Vector::Int[0..4]

  subject { described_class.new(vector) }

  example do
    expect(subject.each).to be_an_instance_of(Enumerator)
  end

  example do
    expect{|b|subject.each(&b)}.to yield_successive_args(*vector)
  end

end
