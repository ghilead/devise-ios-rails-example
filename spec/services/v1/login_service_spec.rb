module V1
  describe LoginService do
    describe "login a user" do
      let(:user) { create(:user) }
      let(:login_context) { double }

      before { allow(login_context).to receive(:error!) }

      subject { described_class.new(params, login_context).call }

      context "with a valid user" do
        let(:params) do
          {
            email: user.email,
            password: user.password,
          }
        end

        it 'returns an authenticated user' do
          expect(subject).to eq user
          expect(login_context).not_to have_received(:error!)
        end
      end

      context "there is no such user" do
        let(:params) do
          {
            email: 'non_existent',
            password: 'fictional',
          }
        end
        it 'calls error method in the context' do
          subject
          expect(login_context).to have_received(:error!).with(any_args, 401)
        end
      end


      context "password doesn't match the user" do
        let(:params) do
          {
            email: user.email,
            password: 'fictional',
          }
        end

        it 'calls error method in the context' do
          subject
          expect(login_context).to have_received(:error!).with(any_args, 401)
        end
      end
    end
  end
end
