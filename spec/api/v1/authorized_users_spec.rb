module V1
  describe AuthorizedUsers do
    include Rack::Test::Methods

    describe "Delete Own Account" do
      before { params.merge! authentication_token: user.authentication_token }

      let(:url) { "v1/users/#{user.id}" }
      let(:user) { create(:user) }
      let(:params) { {} }

      subject { delete url, params }

      it_behaves_like "needs authorization"

      context "with valid token" do
        it_behaves_like "a successful JSON DELETE request"

        it "removes a user" do
          expect{ subject }.to change(User, :count).by(-1)
        end

        it "returns a user" do
          json_response = json_for(subject)
          expect(json_response).to have_key('user')
        end

        it "serializes user with user serializer" do
          expect(subject.body).to eq UserSerializer.new(user).to_json
        end
      end

      context "with id not matching current user" do
        let(:other_user) { create(:user) }
        let(:url) { "v1/users/#{other_user.id}" }

        it_behaves_like "a forbidden JSON request"
      end
    end

    describe "Update User" do
      before { params.merge! authentication_token: user.authentication_token }

      let(:url) { "v1/users/#{user.id}" }
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user) }

      subject { put url, params }

      it_behaves_like "needs authorization"

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
          json_response = json_for(subject)['user'].except('createdAt', 'updatedAt', 'id')
          expected = JSON.parse(UserSerializer.new(
            User.new(params)).to_json
          )['user'].except('createdAt', 'updatedAt', 'id')

          expect(json_response).to eq(expected)
        end
      end

      context "with id not matching current user" do
        let(:other_user) { create(:user) }
        let(:url) { "v1/users/#{other_user.id}" }

        it_behaves_like "a forbidden JSON request"
      end

      context "with invalid params" do
        let(:params) { attributes_for(:user, email: 'not_valid_email') }

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
