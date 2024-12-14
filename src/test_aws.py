import boto3
import os


def verify_aws_setup():
    """Verify AWS credentials are properly configured"""
    try:
        # Check if credentials file exists
        aws_creds_path = os.path.expanduser("~/.aws/credentials")
        if not os.path.exists(aws_creds_path):
            raise Exception(f"AWS credentials file not found at {aws_creds_path}")

        # Try to read credentials file
        with open(aws_creds_path, "r") as f:
            if "[default]" not in f.read():
                raise Exception("No default profile found in AWS credentials")

        # Verify AWS credentials work
        s3 = boto3.client("s3")
        s3.list_buckets()

        logger.info("AWS credentials verified successfully")
        return True
    except Exception as e:
        logger.error(f"AWS credential verification failed: {str(e)}")
        raise


def test_aws_credentials():
    try:
        # Print AWS credential file location
        print(
            f"Looking for AWS credentials in: {os.environ.get('AWS_SHARED_CREDENTIALS_FILE')}"
        )

        # Try to list S3 buckets as a simple test
        s3 = boto3.client("s3")
        response = s3.list_buckets()
        print("AWS Credentials are working!")
        print(f"Found {len(response['Buckets'])} buckets")
        return True
    except Exception as e:
        print(f"AWS Credential Error: {str(e)}")
        return False


if __name__ == "__main__":
    test_aws_credentials()
    verify_aws_setup()
