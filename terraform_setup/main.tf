resource "aws_instance" "test-Server2" {
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.medium"
  availability_zone      = "us-east-1"
  vpc_security_group_ids = [aws_security_group.my_sg1.id]
  key_name               = "JenkinSerP1key"
  tags = {
    name = "kubernetes_instance"
  }
   connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("./JenkinSerP1key.pem")
     
    }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server2"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server2.public_ip} > inventory "
  }
 provisioner "local-exec" {
 command = "ansiblePlaybook installation: 'ansible', playbook: '/var/lib/jenkins/workspace/Health-care-Project/terraform_setup/ansible-playbook.yml"
   } 
}
