shared_examples "needs authorization" do
  context "without authentication" do
    before { params.merge! userToken: nil, userEmail: nil}

    it_behaves_like "an unauthorized JSON request"
  end

  context "with invalid authentication" do
    before { params.merge! build(:invalid_authentication) }
    it_behaves_like "a forbidden JSON request"
  end
end
