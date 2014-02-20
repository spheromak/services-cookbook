### 1.2.0
* switch to rubocop
* update etcd gem to 0.0.6
* compatable with etcd 0.2.0 & 0.3.0

### 1.1.1
* bugfix remove of options attr from endoint
* cleanup tailor issues

### 1.1.0
* add all method to services that returns an array of all services
* add subscribed method to services that returns array of all services a node is mapped too

### 1.0.6
* revert naming change

### 1.0.5
* Fix bug where .load method was returnign a hash instead of self
* make compatable with the 0.0.4 etcd-ruby gem
* make service return objects for endpoint and members instead of hashes.
