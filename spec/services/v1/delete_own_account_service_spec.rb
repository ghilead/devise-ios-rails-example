module V1
  describe DeleteOwnAccountService do
    let!(:user) { create(:user) }
    let(:params) { {} }

    subject { described_class.new(user, params).call! }

    it "removes a user" do
      expect{ subject }.to change(User, :count).by(-1)
    end

    it "returns a user" do
      expect(subject).to be_a User
    end

    context "with a nil instead of a user" do
      subject { described_class.new(nil, params).call! }

      it { is_expected.to be_nil }
    end
  end
end
