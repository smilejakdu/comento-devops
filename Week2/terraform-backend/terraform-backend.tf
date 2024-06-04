resource "aws_s3_bucket" "test-s3-tf-state" {
  // AWS S3 버킷을 생성하는 리소스를 정의합니다.

  // 버킷 이름
  // 생성할 S3 버킷의 이름을 "ash-test-s3-bucket-testuser"로 설정합니다.
  bucket = "ash-test-s3-bucket-testuser"

  // 태그명
  // S3 버킷에 "Name"이라는 키와 "ash-test-s3-bucket-testuser"라는 값을 가진 태그를 추가합니다.
  tags = {
    "Name" = "ash-test-s3-bucket-testuser"
  }
}

resource "aws_dynamodb_table" "test-ddb-tflock-state" {

  // 프로비저닝 전 S3 Bucket이 생성되어야 함
  depends_on = [aws_s3_bucket.test-s3-tf-state]

  // 테이블 이름
  name = "ash-test-ddb-table-testuser"

  // 파티션 키
  attribute {
    // 파티션 키 이름
    name = "LockID"

    // 문자열
    type = "S"
  }

  // 용량 모드 - 온디맨드 방식
  billing_mode = "PAY_PER_REQUEST"

  // 해쉬키 - 파티션 키를 사용
  hash_key = "LockID"

  // 태그
  tags = {
    "Name" = "ash-test-ddb-table-testuser"
  }
}