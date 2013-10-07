# vim: ft=sh:
etcdctl="/usr/local/bin/etcdctl"
endpoint='127.0.0.10
https
80'
member1='127.0.0.2
tcp
1024
testing'
member2='127.0.0.3
tcp
1024
testing'
@test "service endpoint should be registered" {
  res=$($etcdctl get /services/testing/endpoint)
  echo "$res"
  [ "$endpoint" == "$res" ]
}

@test "member1 data" {
  res=$($etcdctl get /services/testing/members/member1)
  echo "$res"
  [ "$member1" == "$res" ]
}

@test "member2 data" {
  res=$($etcdctl get /services/testing/members/member2)
  echo "$res"
  [ "$member2" == "$res" ]
}
