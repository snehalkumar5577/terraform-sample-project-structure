env_name      = "dev01"
region        = "us-east-2"

tags = {
  env   = "dev01"
  owner = "snehal"
}

vpc = {
  cidr            = "10.0.0.0/16"
  azs             = ["a", "b", "c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
