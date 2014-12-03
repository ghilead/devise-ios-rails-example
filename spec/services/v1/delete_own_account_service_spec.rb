module V1
  describe DeleteOwnAccountService do
    let!(:user) { create(:user) }
    let(:params) { { id: user.id } }

    subject { described_class.new(user, params).call }

    it "removes a user" do
      expect{ subject }.to change(User, :count).by(-1)
    end

    it "returns a user" do
      expect(subject).to be_a User
    end

    context "with a nil instead of a user" do
      subject { described_class.new(nil, params).call }

      it { is_expected.to be_nil }
    end

    context "with id not matching current user" do
      let(:params) { { id: create(:user).id } }

      it "raise forbidden error" do
        expect{ subject }.to raise_error(ForbiddenError)
      end
    end

    context "with non existing user to delete" do
      let(:params) { { id: 999 } }

      it "raise not found error" do
        expect{ subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
