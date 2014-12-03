shared_examples "needs authorization" do
  context "without a token" do
    before { params.merge! authentication_token: nil}

    it_behaves_like "an unauthorized JSON request"
  end

  context "with invalid token" do
    before { params.merge! authentication_token: 'invalid token' }

    it_behaves_like "a forbidden JSON request"
  end
end
