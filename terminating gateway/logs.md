### Getting this error 
https://developer.hashicorp.com/consul/tutorials/connect-services/terminating-gateway?productSlug=consul&tutorialSlug=developer-mesh&tutorialSlug=terminating-gateways-connect-external-services

# What is working 

1. API Gateway works, i can get to hashicups
2. DNS lookup fails.... 
3. Cant get to my terminating gateway to link 

## when i perfrom 
kubectl exec -it svc/consul-server --namespace consul -- /bin/sh -c "nslookup -port=8600 managed-aws-rds.virtual.consul
127.0.0.1"

#### results  ## which is wrong
Defaulted container "consul" out of: consul, locality-init (init)
Server:         127.0.0.1
Address:        127.0.0.1:8600



