# # Note that this is an example config file and is not intended to be functional as-is.
# # Full configuration options can be found at https://www.boundaryproject.io/docs/configuration/controller

# # Disable memory lock: https://www.man7.org/linux/man-pages/man2/mlock.2.html
 disable_mlock = true

# # Controller configuration block
 controller {
#   # This name attr must be unique across all controller instances if running in HA mode
   name = "boundary-controller-2"
   description = "A controller for a demo!"

#   # Database URL for postgres. This can be a direct "postgres://"
#   # URL, or it can be "file://" to read the contents of a file to
#   # supply the url, or "env://" to name an environment variable
#   # that contains the URL.
   database {
           url = "env://BOUNDARY_DB_CONNECTION"
#     url="postgresql://admin:password@10.10.3.2:5432/boundary"
   }
 }

# # API listener configuration block
 listener "tcp" {
#   # Should be the address of the NIC that the controller server will be reached on
   address = "10.10.3.4:9200"
#   # The purpose of this listener block
   purpose = "api"

#   tls_disable = false
  tls_disable = false
  tls_cert_file = "/etc/boundary.d/tls/cert.pem"
  tls_key_file = "/etc/boundary.d/tls/key.pem"

#   # Uncomment to enable CORS for the Admin UI. Be sure to set the allowed origin(s)
#   # to appropriate values.
#   #cors_enabled = true
#   #cors_allowed_origins = ["https://yourcorp.yourdomain.com", "serve://boundary"]
 }

# # Data-plane listener configuration block (used for worker coordination)
 listener "tcp" {
#   # Should be the IP of the NIC that the worker will connect on
   address = "10.10.3.4:9201"
#   # The purpose of this listener
   purpose = "cluster"
 }

listener "tcp" {
  # Should be the address of the NIC where your external systems'
  # (eg: Load-Balancer) will connect on.
  address = "10.10.3.4:9203"
  # The purpose of this listener block
  purpose = "ops"

  tls_disable = false
  tls_cert_file = "/etc/boundary.d/tls/cert.pem"
  tls_key_file = "/etc/boundary.d/tls/key.pem"

}

# # Root KMS configuration block: this is the root key for Boundary
# # Use a production KMS such as AWS KMS in production installs
# kms "aead" {
#   purpose = "root"
#   aead_type = "aes-gcm"
#   key = "sP1fnF5Xz85RrXyELHFeZg9Ad2qt4Z4bgNHVGtD6ung="
#   key_id = "global_root"
# }
kms "transit" {
  purpose    = "root"
  address    = "http://10.10.3.2:8200"  # Update if Vault is on another host
  token      = "hvs.CAESINaYLx2crRpy0vaIUk0-HvAxr_pM3CKoppB8UDIOM62yGh4KHGh2cy5ZdGJaeXZuUDZYSWk5bEVSWEFMY0dONmE"       # Replace with an actual token
  key_name   = "boundary"               # Your Vault Transit key name
  mount_path = "transit/"               # Default Vault mount path for transit secrets
  #tls_ca_file = "/etc/vault.d/vault.crt"

}

# # Worker authorization KMS
# # Use a production KMS such as AWS KMS for production installs
# # This key is the same key used in the worker configuration
 kms "transit" {
   purpose = "worker-auth"
#   aead_type = "aes-gcm"
#   key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
#   key_id = "global_worker-auth"
  address    = "http://10.10.3.2:8200"  # Update if Vault is on another host
  token      = "hvs.CAESINaYLx2crRpy0vaIUk0-HvAxr_pM3CKoppB8UDIOM62yGh4KHGh2cy5ZdGJaeXZuUDZYSWk5bEVSWEFMY0dONmE"       # Replace with an actual token
  key_name   = "worker-auth"               # Your Vault Transit key name
  mount_path = "transit/"               # Default Vault mount path for transit secrets
 # tls_ca_file = "/etc/vault.d/vault.crt"

 }

# # Recovery KMS block: configures the recovery key for Boundary
# # Use a production KMS such as AWS KMS for production installs
 kms "transit" {
   purpose = "recovery"
#   aead_type = "aes-gcm"
#   key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
#   key_id = "global_recovery"

  address    = "http://10.10.3.2:8200"  # Update if Vault is on another host
  token      = "hvs.CAESINaYLx2crRpy0vaIUk0-HvAxr_pM3CKoppB8UDIOM62yGh4KHGh2cy5ZdGJaeXZuUDZYSWk5bEVSWEFMY0dONmE"       # Replace with an actual token
  key_name   = "recovery"               # Your Vault Transit key name
  mount_path = "transit/"               # Default Vault mount path for transit secrets
  #tls_ca_file = "/etc/vault.d/vault.crt"

 }
