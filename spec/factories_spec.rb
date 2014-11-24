SKIP_TRAITS = [:without_repeat]

FactoryGirl.factories.each do |factory|
  describe "The #{factory.name} factory" do
    it 'is valid' do
      object = build(factory.name)
      if object.methods.include? :valid?
        expect(object).to be_valid
      end
    end
  end

  factory.defined_traits.each do |trait|
    next if SKIP_TRAITS.include? trait.name
    describe "The #{trait.name} #{factory.name} factory" do
      it 'is valid' do
        object = build(factory.name, trait.name)
        if object.methods.include? :valid?
          expect(object).to be_valid
        end
      end
    end
  end
end
