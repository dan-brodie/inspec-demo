describe google_compute_instance(project: 'chef-gcp-inspec', zone: 'zone', name: 'inspec-instance') do
    it { should exist }
    its('machine_type') { should match 'n1-standard-1' }
    its('tags.items') { should include 'foo' }
    its('tags.items') { should include 'bar' }
    its('tag_count') { should cmp 2 }
    its('service_account_scopes') { should include 'https://www.googleapis.com/auth/compute.readonly' }
    its('metadata_keys') { should include '123' }
    its('metadata_values') { should include 'asdf' }
  end
  
  describe google_compute_instance(project: 'chef-gcp-inspec', zone: 'zone', name: 'nonexistent') do
    it { should_not exist }
  end