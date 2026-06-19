resource aws_ecr_repository test {
    name = var.ecr_repository_name
    image_tag_mutability = "MUTABLE"
    image_scanning_configuration {
        scan_on_push = true
    }
    encryption_configuration {
        encryption_type = "AES256"
    }
}

resource aws_ecr_repository_policy test {
    repository = aws_ecr_repository.test.name
    policy = jsonencode({
        rules = [ {
            rulePriority = 1
            description = "Keep last 10 images"
            selection = {
                tagStatus = "any"
                countType = "imageCountMoreThan"
                countNumber = 10
            }
            action = {
                type = "expire"
            }
        }]
    })
}