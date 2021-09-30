sudo ./kauth.sh 0.0.0.0:8080 kafka-client smartcow kafka-sc --insecure

# https://github.com/akoserwal/keycloak-integrations/blob/master/curl-post-request/keycloak-curl.sh

# token auth

curl --location --request POST 'http://0.0.0.0:8080/auth/realms/access-gateway/protocol/openid-connect/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'username=kafkauser' \
--data-urlencode 'password=kaf111' \
--data-urlencode 'client_id=kafka-client' \
--data-urlencode 'client_secret=aaae1b44-c408-4b47-9f8f-018edff53673' \
--data-urlencode 'grant_type=password'

# introspect

curl --location --request POST 'http://0.0.0.0:8080/auth/realms/kafka-client/protocol/openid-connect/token/introspect' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode 'token=<token>' \
--data-urlencode 'client_id=kafka-client' \
--data-urlencode 'client_secret=aaae1b44-c408-4b47-9f8f-018edff53673'
