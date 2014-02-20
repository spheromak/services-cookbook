# vim: ft=sh:
etcdctl="/usr/local/bin/etcdctl"
endpoint='127.0.0.10'
member1='127.0.0.2'
member2='127.0.0.3'

@test "service endpoint should be registered" {
  res=$($etcdctl get /services/testing/endpoint/ip)
  echo "$res"
  [ "$endpoint" == "$res" ]
}

@test "member1 data" {
  res=$($etcdctl get /services/testing/members/member1/ip)
  echo "$res"
  [ "$member1" == "$res" ]
}

@test "member2 data" {
  res=$($etcdctl get /services/testing/members/member2/ip)
  echo "$res"
  [ "$member2" == "$res" ]
}
