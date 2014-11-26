module V1
  describe Users do
    include Rack::Test::Methods
    describe 'login a user' do
      let(:url) { 'v1/login' }
      subject { get url, params }

      context 'with valid params' do
        let(:params) do
          {
            username: 'ios_man',
            password: 'alcatraz',
          }
        end

        it_behaves_like 'a successful JSON GET request'
      end

      context 'with invalid params' do
        it_behaves_like 'an unsuccessful JSON request' do
          let(:params) { {} }
        end

        it_behaves_like 'an unsuccessful JSON request' do
          let(:params) { { username: 'ios_man' } }
        end

        it_behaves_like 'an unsuccessful JSON request' do
          let(:params) { { password: 'alcatraz' } }
        end
      end
    end
  end
end
