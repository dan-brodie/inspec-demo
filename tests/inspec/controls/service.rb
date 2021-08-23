my_services = yaml(content: inspec.profile.file('services.yml')).params

my_services.each do |s|
  describe service(s['service_name']) do
    it { should be_running }
end

describe port(s['port']) do
  it { should be_listening }
  end
end