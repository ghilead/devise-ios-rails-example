module V1
  describe RequestPasswordReset do
    include Rack::Test::Methods

    describe "request a password reset" do
      let(:url) { 'v1/users/password' }
      let(:user) { create(:user) }

      subject { post url, params }

      context "with valid params" do
        let(:params) { { user: { email: user.email } } }


        it "returns an OK (204) status code" do
          expect(subject.status).to eq(204)
        end

        it "returns empty body" do
          expect(subject.body).to be_empty
        end

        it "sends reset instructions to a user" do
          expect{ subject }.to change(ActionMailer::Base.deliveries, :count).by(1)
        end
      end

      context "there is no such user" do
        let(:params) { { user: { email: 'non_existent' } } }

        it "calls error method in the context" do
          json = json_for(subject)
          expect(json).to eq(
            'error' => {
              message: "Couldn't find User",
              code: 0,
              status: 404,
            }.stringify_keys
          )
        end
      end
    end
  end
end
