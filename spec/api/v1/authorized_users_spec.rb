module V1
  describe AuthorizedUsers do
    include Rack::Test::Methods

    describe "Update User" do
      before { params.merge! authentication_token: user.authentication_token }

      let(:url) { 'v1/users' }
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user) }

      subject { put url, params }

      context "with valid token" do
        it_behaves_like "a successful JSON PUT request"
        it "doesn't create a new record" do
          expect{ subject }.not_to change(User, :count)
        end

        it "returns a user" do
          json_response = json_for(subject)
          expect(json_response).to have_key('user')
        end

        it "serializes user with user serializer" do
          expect(subject.body).to eq UserSerializer.new(user).to_json
        end
      end

      context "with invalid token" do
        before { params.merge! authentication_token: 'invalid token' }

        it_behaves_like "a forbidden JSON request"
      end

      context "with invalid params" do
        let(:params) { { email: 'not_valid_email' } }

        it_behaves_like "a bad JSON request", 422

        it "returns error object" do
          error = {
            message: 'Validation failed: Email is invalid',
            code: 0,
            status: 422
          }.stringify_keys
          json_response = json_for(subject)

          expect(json_response).to eq('error' => error)
        end
      end
    end
  end
end
