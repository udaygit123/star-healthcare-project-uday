resource "aws_instance" "test-server2" {
  ami                    = "ami-007855ac798b5175e"
  instance_type          = "t2.micro"
  key_name = "JenkinSerP1key"
  vpc_security_group_ids= ["sg-077ce7b1c53c11b8a"]
  
 
  
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
 command = "ansiblePlaybook disableHostKeyChecking: true, installation: 'ansible', inventory: '/usr/bin/ansible', playbook: '/var/lib/jenkins/workspace/Health-care-Project/terraform_setup/ansible-playbook.yml"
   } 
}
