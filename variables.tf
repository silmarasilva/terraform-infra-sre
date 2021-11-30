
#--------------IMAGENS-----------------------
variable "image_api_clientes" {
    default = "ami-0130f97568df8bdb0"
    type = string
    description = "Imagem que contem a API de Clientes"
}

variable "image_api_enderecos" {
    default = "ami-0b3fcdf6a28291b12"
    type = string
    description = "Imagem que contem a API de Clientes"
}

variable "image_api_produtos" {
    default = "ami-015c47c0dcac43438"
    type = string
    description = "Imagem que contem a API de Produtos"
}

variable "image_api_vendas" {
    default = "ami-0e2dda35b3dc59cd1"
    type = string
    description = "Imagem que contem a API de Vendas/Inventário"
}

variable "bastion_image" {
    default = ""
    type = string
    description = "Imagem para o bastion"
}

#----------- -----TYPE INSTANCE-----------------------
variable "instance_type" {
    default = "t2.micro"
    type = string
    description = "Instancias padrão t2 micro"
}

#----------- --------CHAVES----------------------------
variable "my_key_name" {
    default = "aws-key-name"
    type = string
    description = "aws-key-name"
}

#----------- -------BANCO - RDS--------------------------

variable "db_user" {
    default = "silale"
    type = string
    description = "user db_silale RDS"
}

variable "db_password" {
    default = "1234"
    type = string
    description = "user db_password RDS"
}

variable "db_name" {
    default = "db_silale"
    type = string
    description = "user db_password RDS"
}



