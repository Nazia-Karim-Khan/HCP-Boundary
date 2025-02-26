hcp_boundary_cluster_id = "0a8d53cf-5573-4883-a5c9-0ca23a2abc75"

listener "tcp" {
  address = "127.0.0.1:9202"
  purpose = "proxy"
}

worker {
  public_addr = "minio-worker"
  auth_storage_path = "/boundary/minio-worker"
  recording_storage_path = "/tmp/boundary"
  tags {
    type = ["minio", "openssh"]
  }
}
