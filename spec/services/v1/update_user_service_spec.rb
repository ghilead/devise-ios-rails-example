module V1
  describe UpdateUserService do
    let(:user) { create(:user) }
    let(:params) { attributes_for(:user, id: user.id, email: 'new@example.com') }

    subject { described_class.new(user, params).call! }

    it "returns a user" do
      expect(subject).to be_a User
    end

    it "updates a user" do
      expect(subject.email).to eq params[:email]
    end

    context "with a blank params" do
      [{}, nil].each do |blank_params|
        subject { described_class.new(user, blank_params).call! }

        it "raises not found error" do
          expect{ subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "with a nil instead of a user" do
      subject { described_class.new(nil, params).call! }

      it { is_expected.to be_nil }
    end

    context "with invalid attributes" do
      let(:params)  { { id: user.id, email: 'not_valid_email' } }

      it "raises validation exception" do
        expect{ subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
