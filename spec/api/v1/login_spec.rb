module V1
  describe Login do
    include Rack::Test::Methods
    %w(get post).each do |request_method|
      describe "login a user" do
        let(:url) { 'v1/login' }
        let(:user) { create(:user) }
        subject { public_send(request_method, url, params) }

        context "with valid params" do
          let(:params) do
            {
              email: user.email,
              password: user.password,
            }
          end

          it_behaves_like 'a good JSON request', 200
        end

        context "with invalid params" do
          invalid_params = [
            {},
            { email: 'ios_man@example.com' },
            { password: 'alcatraz' },
          ]
          invalid_params.each do |invalid_param|
            it_behaves_like "an unsuccessful JSON request" do
              let(:params) { invalid_param }
            end
          end
        end

        context "with a valid user" do
          let(:params) do
            {
              email: user.email,
              password: user.password,
            }
          end

          it "returns a user" do
            json_response = json_for(subject)
            expect(json_response).to have_key('user')
          end

          it "serializes user with user serializer" do
            expect(subject.body).to eq UserSerializer.new(user).to_json
          end
        end

        context "there is no such user in DB" do
          let(:params) do
            {
              email: 'non_existent',
              password: 'fictional',
            }
          end

          it_behaves_like "an unauthorized JSON request"
        end

        context "password doesn't match the user" do
          let(:params) do
            {
              email: user.email,
              password: 'fictional',
            }
          end

          it_behaves_like "an unauthorized JSON request"
        end
      end
    end
  end
end
