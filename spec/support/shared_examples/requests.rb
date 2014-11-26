shared_examples 'a bad request' do |response_code|
  it "returns a bad request (#{response_code}) status code" do
    expect(subject.status).to eq(response_code)
  end

  it "is a JSON response" do
    expect(subject.content_type).to eq 'application/json'
  end
end

shared_examples "a good request" do |response_code|
  it "returns an OK (#{response_code}) status code" do
    expect(subject.status).to eq(response_code)
  end

  it "is a JSON response" do
    expect(subject.content_type).to eq 'application/json'
  end
end

shared_examples "a successful JSON GET request" do
  it_behaves_like 'a good request', 200
end

shared_examples "a successful JSON PUT request" do
  it_behaves_like 'a good request', 200
end

shared_examples "a successful JSON POST request" do
  it_behaves_like 'a good request', 201
end

shared_examples "a successful JSON DELETE request" do
  it_behaves_like 'a good request', 201
end

shared_examples "an unsuccessful JSON request" do
  it_behaves_like 'a bad request', 400
end

shared_examples "an unauthorized JSON request" do
  it_behaves_like 'a bad request', 401
end

shared_examples "a not found JSON request" do
  it_behaves_like 'a bad request', 404
end
