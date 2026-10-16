resource "aws_ecr_repository" "app" {
  name = var.app_name

  # IMMUTABLE means a tag can be pushed once. Pushing the same tag again fails,
  # which prevents the silent "same tag, different code" problem.
  image_tag_mutability = "IMMUTABLE"

  # Scan each image for known vulnerabilities when it is pushed
  image_scanning_configuration {
    scan_on_push = true
  }

  # Encrypt images at rest with AWS-managed keys
  encryption_configuration {
    encryption_type = "AES256"
  }
}

# Keep the most recent 10 images so rollback targets survive, and delete older ones
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep the last 10 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 10
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
