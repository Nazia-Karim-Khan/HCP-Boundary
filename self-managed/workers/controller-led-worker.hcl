disable_mlock = true

 listener "tcp" {
     purpose = "proxy"
     address = "0.0.0.0:9202"
}

 worker {

#   # Workers must be able to reach controllers on :9201
  initial_upstreams = [
     "10.10.3.2",
     "10.10.3.3",
     "10.10.3.4",
   ]

#   public_addr = "myhost.mycompany.com"

   tags {
     type   = ["ctrl-led"]
#     region = ["us-east-1"]
   }

  auth_storage_path = "/etc/boundary.d/ctrl-worker1"
  controller_generated_activation_token = "neslat_2KqKh4zbBKYvETvyFvPBwSMjeqhrmFgxEzzrqRndzyf2GUnzBcsrzRjcGBEXP1cm6sfLenqh25wV7TVGhjZ8eYpJ2rCHN"

 }

# # must be same key as used on controller config
# kms "aead" {
#     purpose = "worker-auth"
#     aead_type = "aes-gcm"
#     key = "8fZBjCUfN0TzjEGLQldGY4+iE9AkOvCfjh7+p0GtRBQ="
#     key_id = "global_worker-auth"
# }
