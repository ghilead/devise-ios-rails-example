module V1
  describe ChangePasswordService do
    let(:user) { create(:user) }
    let(:params) do
      { id: user.id, password: 'fresh', password_confirmation: 'fresh' }
    end

    subject { described_class.new(user, params).call }

    it "returns a user" do
      expect(subject).to be_a User
    end

    it "updates user password" do
      expect(subject.password).to eq params[:password]
    end

    context "change a password of a different user" do
      let(:other_user) { create(:user) }
      let(:params) do
        { id: other_user.id, password: 'fresh', password_confirmation: 'fresh' }
      end

      it 'raises forbidden error' do
        expect{ subject }.to raise_error(ForbiddenError)
      end
    end

    context "with a blank params" do
      [{}, nil].each do |blank_params|
        subject { described_class.new(user, blank_params).call }

        it "raises not found error" do
          expect{ subject }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end

    context "with a nil instead of a user" do
      subject { described_class.new(nil, params).call }

      it { is_expected.to be_nil }
    end

    context "with invalid attributes" do
      let(:params)  do
        { id: user.id, password_confirmation: 'not_matching', password: 'fresh'}
      end

      it "raises validation exception" do
        expect{ subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
