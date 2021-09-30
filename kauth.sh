#!/bin/bash

if [ $# -ne 5 ]; then
  echo 1>&2 "Usage: . $0 hostname realm username clientid"
  echo 1>&2 "  options:"
  echo 1>&2 "    hostname: localhost:8081"
  echo 1>&2 "    realm:keycloak-demo"
  echo 1>&2 "    clientid:demo"
  echo 1>&2 "    For verify ssl: use 'y' (otherwise it will send curl post with --insecure)"
  
  return
fi

HOSTNAME=$1
REALM_NAME=$2
USERNAME=$3
CLIENT_ID=$4
SECURE=$5



KEYCLOAK_URL=http://$HOSTNAME/auth/realms/$REALM_NAME/protocol/openid-connect/token



echo "Using Keycloak: $KEYCLOAK_URL"
echo "realm: $REALM_NAME"
echo "client-id: $CLIENT_ID"
echo "username: $USERNAME"
echo "secure: $SECURE"


if [[ $SECURE = 'y' ]]; then
	INSECURE=
else 
	INSECURE=--insecure
fi


echo -n Password: 
read -s PASSWORD

export TOKEN=$(curl -X POST "$KEYCLOAK_URL" "$INSECURE" \
 -H "Content-Type: application/x-www-form-urlencoded" \
 -d "username=$USERNAME" \
 -d "password=$PASSWORD" \
 -d 'grant_type=password' \
 -d "client_id=$CLIENT_ID" \
 -d "client_secret=113f06ec-60ae-482b-80b4-4e3b5ed7b0cc")

echo $TOKEN

if [[ $(echo $TOKEN) != 'null' ]]; then
	export KEYCLOAK_TOKEN=$TOKEN
fi