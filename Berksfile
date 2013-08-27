#
# vim: set ft=ruby:
#
site :opscode

metadata

# solo-search for intgration tests
group :integration do
  cookbook 'apt'
  cookbook 'curl'
  cookbook 'etcd'
  cookbook 'services_test',
    path: "test/cookbooks/services_test"
end
