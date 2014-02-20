#
# vim: set ft=ruby:
#
site :opscode

metadata

# solo-search for intgration tests
group :integration do
  cookbook 'apt'
  cookbook 'curl'
  cookbook 'etcd', '>= 2.1.1'
  cookbook 'services_test',
    path: "test/cookbooks/services_test"
end
