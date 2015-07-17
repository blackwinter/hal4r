describe Hal4R::Matrix do

  step = 5

  subject { described_class.new(step) }

  example do
    expect(subject.get(0)).to eq(0)
    expect(subject.vector(0)).to be_an_instance_of(Hal4R::Vector)
    expect{subject.vector(step)}.to raise_error(GSL::ERROR::EINVAL, /row index is out of range/)
  end

  example do
    expect(subject.get(step)).to eq(0)
    expect(subject.vector(0)).to be_an_instance_of(Hal4R::Vector)
    expect(subject.vector(step)).to be_an_instance_of(Hal4R::Vector)
  end

  example do
    expect(subject.each_col).to be_an_instance_of(Enumerator)
  end

  example do
    expect{|b|subject.each_col(&b)}.to yield_successive_args(*[GSL::Vector::Int::Col::View] * subject.size)
  end

end
