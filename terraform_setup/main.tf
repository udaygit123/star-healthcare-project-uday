resource "aws_instance" "Test-Server2" {
  ami                    = "ami-0e58f89e91723af4c"
  instance_type          = "t2.medium"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.my_sg1.id]
  key_name               = "JenkinSerP1key.pem"
  tags = {
    name = "kubernetes_instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install docker.io -y",
      "sudo wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo chmod +x /home/ubuntu/minikube-linux-amd64",
      "sudo cp minikube-linux-amd64 /usr/local/bin/minikube",
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
      "sudo chmod +x /home/ubuntu/kubectl",
      "sudo cp kubectl /usr/local/bin/kubectl",
      "sudo usermod -aG docker ubuntu"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("./JenkinSerP1key.pem")
    }
  }
}
