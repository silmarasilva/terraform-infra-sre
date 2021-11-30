// Ubuntu - Bastion Host
// O Bastion Host é o EC2 que permite a comunicação externa entre a rede pública e a rede privada por meio do protocolo SSH(linux) ou RDP(windows), criando uma espécie de camada de segurança.
// 

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "bastion_silale" {
  depends_on = [aws_db_instance.db_silale] #wait for the db to be ready
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet0-pub1A-silale.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_pub_bastiao_silale.id, aws_vpc.vpc1-silale.default_security_group_id]
  key_name                    = var.my_key_name
  /*user_data                   = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y apache2
              sudo apt-get install -y mysql-client
              sudo systemctl start apache2
              sudo systemctl enable apache2
              
              EOF  
  */
  tags = {
    Name = "bastion-silale"
  }
  root_block_device {
    volume_size = 8
    delete_on_termination = true
  }
// fazendo conexao ssh
connection {
type = "ssh"
user = "ubuntu"
private_key = file ("~/aws-key-name.pem") //home/sil_silva/aws-key-name.pem
host = self.public_dns //dns da instancia bastion
}
//copiando a chave para o bastion
provisioner "file"{
  source = "~/aws-key-name.pem" 
  destination = "/home/ubuntu/aws-key-name.pem"
}

provisioner "file" {
  source      = "/home/sil_silva/workspace/terraform/project-infra-sre/bdscript.sql"
    destination = "/home/ubuntu/bdscript.sql"
  }

provisioner "remote-exec" {
  inline = [
  "sudo apt-get update",
  "chmod 700 aws-key-name.pem",
  "sudo apt install mysql-client-core-8.0",
  "mysql -h${aws_db_instance.db_silale.address} -P 3306 -u${var.db_user} -p${var.db_password} < bdscript.sql"
  //"mysql -ualesil -hdb-alesil.cxycaymkd24m.us-east-1.rds.amazonaws.com -P 3306 -palesil2021 < script.sql"
  ]
  }
  }



//O parâmetro associate_public_ip_address fará com que a instância tenha disponibilizado um endereço IP público, onde qualquer requisição realizada nele será encaminhada para a instância.
//O bloco tags no caso acima permitiu definir uma tag que facilitará a busca por essa instância, no caso, a tag name, pois é uma boa prática definir descrições breves a partir da tag name quando uma instância é criada.
//Por fim, o parâmetro subnet_id permitiu especificar que a instância terá uma interface virtual conectada a subnet pública dentro da nossa VPC, e assim a instância poderá ser acessada via Internet através do endereço IP público associado a ela e, claro, de acordo com as regras definidas no Security Group associado a instância
// #!/bin/bash shell scrip
// sudo apt-get update atualiza o repositório
// sudo apt-get install -y apache2 - advanced packege tool
// -y = sim
// sudo apt-get install -y mysql-client - acessar o bd
// sudo systemctl start apache2 - inicia o pache
// sudo systemctl enable apache2 - permite que o apache seja carregado automaticamente