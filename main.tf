resource "null_resource" "tfc_test" {
  count = 8
  provisioner "local-exec" {
    command = "echo 'Test ${count.index}'"
  }
}