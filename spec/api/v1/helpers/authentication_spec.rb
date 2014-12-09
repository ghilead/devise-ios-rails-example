module V1
  module Helpers
    describe Authentication do
      before { allow(helper).to receive(:headers).and_return({}) }
      before { allow(helper).to receive(:params).and_return({}) }

      let(:helper) { double.extend(described_class) }
      let(:user) { create(:user) }
      let(:valid_token) { user.authentication_token }
      let(:valid_email) { user.email }

      describe "#authorize!" do
        subject { helper.authorize! }

        context "has been authenticated properly" do
          before { allow(helper).to receive(:token).and_return(valid_token) }
          before { allow(helper).to receive(:email).and_return(valid_email) }
          before { allow(helper).to receive(:current_user).and_return(user) }

          it "returns current user" do
            expect(subject).to eq helper.current_user
          end
        end

        context "no token provided" do
          before { allow(helper).to receive(:token).and_return(nil) }

          it "fails with forbidden error" do
            expect{ subject }.to raise_error(UnauthorizedError)
          end
        end

        context "tried to authenticated but didn't matched a user" do
          before { allow(helper).to receive(:token).and_return('invalid_token') }
          before { allow(helper).to receive(:email).and_return('invalid@example.com') }
          before { allow(helper).to receive(:current_user).and_return(nil) }

          it "fails with forbidden error" do
            expect{ subject }.to raise_error(ForbiddenError)
          end
        end
      end

      describe "#current_user" do
        subject { helper.current_user }
        before { allow(helper).to receive(:authenticate).and_return(user) }

        it "returns currently authenticated user" do
          expect(subject).to eq helper.authenticate
        end
      end

      describe "#authenticate" do
        subject { helper.authenticate }
        before do
          allow(helper)
            .to receive(:params).and_return(build(:authentication, user: user).to_hash)
        end

        it "returns authenticated user" do
          expect(subject).to eq user
        end

        context "with invalid token" do
        before do
          allow(helper)
            .to receive(:params).and_return(build(:invalid_authentication).to_hash)
        end
          it "returns nil" do
            expect(subject).to be_nil
          end
        end
      end

      describe "#token" do
        subject { helper.token }

        context "having authentication token in params" do
          before do
            allow(helper)
              .to(
                receive(:params)
                .and_return(userToken: 'params_token')
              )
          end

          it "returns token from params" do
            expect(subject).to eq 'params_token'
          end

          context "and having authentication token in headers" do
            before do
              allow(helper)
                .to receive(:headers).and_return(
                  'X-User-Token' => 'header_token',
                  'X-User-Email' => 'valid@example.com'
                )
            end
            it "returns token from params" do
              expect(subject).to eq 'params_token'
            end
          end
        end

        context "and having authentication token in headers" do
          before do
            allow(helper)
              .to receive(:params).and_return(authentication_token: nil)
            allow(helper)
              .to receive(:headers).and_return(
                  'X-User-Token' => 'header_token',
                  'X-User-Email' => 'valid@example.com'
              )
          end

          it "returns token from headers" do
            expect(subject).to eq 'header_token'
          end
        end

        context "no authentication token" do
          before do
            allow(helper)
              .to receive(:params).and_return(authentication_token: nil)
            allow(helper)
              .to receive(:headers).and_return('X-Authentication-Token' => nil)
          end

          it "returns nil" do
            expect(subject).to be_nil
          end
        end
      end
    end
  end
end
