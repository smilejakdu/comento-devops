terraform {

  // AWS로 Cloud Provider 설정 및 API 변환 바이너리 4.0 이상으로 받음
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  // terraform.tfstate - Terraform 프로비저닝 자원 상태 파일 저장소를 S3 버킷, Lock 관리를 DynamoDB에서 관리
  backend "s3" {
    // 리전 선택 - 서울 리전
    region = "ap-northeast-2"

    // Lock 관리를 위한 DynamoDB 테이블명
    dynamodb_table = "ash-test-ddb-table-testuser"

    // Terraform 프로비저닝 자원 상태 파일 저장소명
    bucket = "ash-test-s3-bucket-testuser"

    // Terraform 프로비저닝 자원 상태 파일명
    key = "terraform.tfstate"

    // 버킷 암호화 적용
    encrypt = "true"
  }
}

// 리전명을 변수에서 할당
provider "aws" {
  region = var.aws_region
}