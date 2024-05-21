# Bucket creation
resource "aws_s3_bucket" "my_s3_bucket"{
    bucket = "my-s3-test-bucket02"

    tags = {
    Name = "My bucket"
    Enviroment ="Dev"
}
}
