# Steps to enable Terminating Gateway

export CONSUL_HTTP_TOKEN=$(kubectl get secret consul-bootstrap-acl-token -n consul --template='{{.data.token | base64decode }}')
echo $CONSUL_HTTP_TOKEN


Note: Regardless of the protocol specified in the ServiceDefaults, L7 intentions are not currently supported with ServiceDefaults destinations.


## write a policy 



partition_prefix "" {
service "google-https" {
  policy = "write"
    }
}
consul acl policy create -name "google-https-write-policy" -rules @write-policy.hcl

ID:           bc348124-b9b7-24f0-695a-b534ed67d776
Name:         google-https-write-policy
Partition:    default
Namespace:    default
Description:  
Datacenters:  
Rules:
service "google-https" {
  policy = "write"
}


## Obtain the ID of the terminating gateway role.

consul acl role list -format=json | jq --raw-output '[.[] | select(.Name | endswith("-terminating-gateway-acl-role"))] | if (. | length) == 1 then (. | first | .ID) else "Unable to determine the role ID because there are multiple roles matching this name.\n" | halt_error end'

e1e64ba3-50cf-9e65-c8ef-2b9e84fc5665

## Update the terminating gateway ACL role with the new policy.
consul acl role update -id e1e64ba3-50cf-9e65-c8ef-2b9e84fc5665 -policy-name google-https-write-policy

consul acl role update -id e1e64ba3-50cf-9e65-c8ef-2b9e84fc5665 -policy-name google-https-write-policy

ID:           e1e64ba3-50cf-9e65-c8ef-2b9e84fc5665
Name:         consul-terminating-gateway-acl-role
Partition:    default
Namespace:    default
Description:  ACL Role for consul-terminating-gateway
Policies:
   d6ce62c7-73aa-eef3-b4f5-e27ada634561 - terminating-gateway-policy
   bc348124-b9b7-24f0-695a-b534ed67d776 - google-https-write-policy



## kubectl exec deploy/static-client -n ping  -- curl -vvvs https://google.com/


Defaulted container "consul-dataplane" out of: consul-dataplane, static-client, consul-connect-inject-init (init)
error: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "db0d87ffeee88dfa9b0ceb0671f512dcf39bceb787aa876784129cb217bef2ca": OCI runtime exec failed: exec failed: unable to start container process: exec: "curl": executable file not found in $PATH: unknown

