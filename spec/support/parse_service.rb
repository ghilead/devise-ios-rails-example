def stub_get_parse_story
  allow_any_instance_of(Parse::Query).to receive(:eq)
    .and_return(OpenStruct.new(get: OpenStruct.new(first: { 'objectId' => 'parse_id' })))
end
def stub_parse_registration!(result_type)
  case result_type
  when :success
    stub_successful_registration
  when :failure
    stub_failed_registration
  end
end

def stub_successful_registration
  allow_any_instance_of(Parse::User).to receive(:save).and_return({
    "profileName" => 'name',
    "username" => 'username',
    "email" => 'email@example.com',
    "sessionToken" => "dummy_token",
  })
end

def stub_failed_registration
  allow_any_instance_of(Parse::User).to receive(:save).and_raise(
    Parse::ParseProtocolError.new 'error')
end

def stub_parse_authentication!(result_type, user=build(:user))
  case result_type
  when :success
    stub_successful_login(user)
  when :failure
    stub_unsuccessful_login
  end
end

def stub_successful_login(user)
  allow(Parse::User).to receive(:authenticate).and_return(
    "profileName" => user.profile_name,
    "username" => user.name,
    "email" => user.email,
    "sessionToken" => "dummy_token",
  )
end

def stub_unsuccessful_login
  allow(Parse::User).to receive(:authenticate).and_raise(
    Parse::ParseProtocolError.new 'error')
end
