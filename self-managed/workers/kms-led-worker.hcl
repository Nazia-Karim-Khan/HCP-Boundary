disable_mlock = true

listener "tcp" {
    purpose = "proxy"
    tls_disable = true
    address = "0.0.0.0:9202"
}

worker {
  # Name attr must be unique across workers
  name = "kms-worker"
  description = "A default worker created for demonstration"

  # Workers must be able to reach upstreams on :9201
  initial_upstreams = [
    "10.10.3.2:9201",
    "10.10.3.3:9201",
    "10.10.3.4:9201"
  ]

  # public_addr = "myhost.mycompany.com"

  tags {
    type   = ["worker", "egress"]
    # region = ["us-east-1"]
  }
}

# must be same key as used on controller config
 kms "transit" {
   purpose = "worker-auth"
  address    = "http://10.10.3.2:8200"  # Update if Vault is on another host
  token      = "hvs.CAESINaYLx2crRpy0vaIUk0-HvAxr_pM3CKoppB8UDIOM62yGh4KHGh2cy5ZdGJaeXZuUDZYSWk5bEVSWEFMY0dONmE"       # Replace with an actual token
  key_name   = "worker-auth"               # Your Vault Transit key name
  mount_path = "transit/"               # Default Vault mount path for transit secrets

 }

