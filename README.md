# DOSpace

Client library to interact with the DigitalOcean Spaces API.

## Usage

A simple usage example:

```
import 'dart:async';
import 'package:dospace/dospace.dart' as dospace;

main() async {
  dospace.Spaces spaces = new dospace.Spaces(
    region: "nyc3",
    accessKey: "7Q7GAFJ4IXHQVLBRXSRX",
    secretKey: "2JLXa9RqPwpavBkC7dt1MHWUDfd6onaXTXTfSYc5eQ0",
  );
  for (String name in await spaces.listAllBuckets()) {
    print('bucket: ${name}');
    dospace.Bucket bucket = spaces.bucket(name);
    await for (dospace.BucketContent content in bucket.listContents(maxKeys: 3)) {
       print('key: ${content.key}');
    }
  }
  String etag = await spaces.bucket('example').uploadFile(
    'README.md', 'README.md', 'text/plain', dospace.Permissions.public);
  print('upload: $etag');
  await spaces.close();
}
```

## References

* https://developers.digitalocean.com/documentation/spaces/
* https://github.com/agilord/aws_client
* https://github.com/gjersvik/awsdart
* https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html
* https://docs.aws.amazon.com/general/latest/gr/sigv4_signing.html
* https://docs.aws.amazon.com/general/latest/gr/sigv4-signed-request-examples.html
* https://docs.aws.amazon.com/general/latest/gr/signature-v4-test-suite.html



{x-amz-acl: public-read, Content-Length: 94942, Content-Type: image/jpeg, x-amz-date: 20211226T135221Z, x-amz-content-sha256: ebe7348131ea84dd359b61c0bfffe5ea60d15a565df61b62d912dd8aa9b7f65d, Authorization: AWS4-HMAC-SHA256 Credential=DK2R2J6XYEQMMPLSFBUF/20211226/fra1/s3/aws4_request, SignedHeaders=content-length;content-type;host;x-amz-acl;x-amz-content-sha256;x-amz-date, Signature=24b862a5e1bb9dfb1a59790d9e6050a2cf4d7b667b66b63c7996503538ed3702}

{x-amz-acl: public-read, Content-Length: 94942, Content-Type: image/jpeg, x-amz-date: 20211226T135827Z, host: vibespot.fra1.digitaloceanspaces.com, Authorization: AWS4-HMAC-SHA256 Credential=DK2R2J6XYEQMMPLSFBUF/20211226/fra1/s3/aws4_request, SignedHeaders=host;x-amz-date, Signature=468a535b2004a2508a092148cdd810bca63085fb530c7515cebd5e981cd56cb5}

  ```JSON {
      "x-amz-acl": "public-read",
      'Content-Length': 94942,
      'Content-Type': 'image/jpeg',
      'x-amz-date': '20211226T135221Z',
      'x-amz-content-sha256':
          'ebe7348131ea84dd359b61c0bfffe5ea60d15a565df61b62d912dd8aa9b7f65d',
      'Authorization':
          'AWS4-HMAC-SHA256 Credential=DK2R2J6XYEQMMPLSFBUF/20211226/fra1/s3/aws4_request, SignedHeaders=content-length;content-type;host;x-amz-acl;x-amz-content-sha256;x-amz-date, Signature=24b862a5e1bb9dfb1a59790d9e6050a2cf4d7b667b66b63c7996503538ed3702'
    }```

{x-amz-acl: public-read, Content-Length: 95103, Content-Type: multipart/form-data; boundary=--dio-boundary-2199563244, x-amz-date: 20211226T140908Z, x-amz-content-sha256: ebe7348131ea84dd359b61c0bfffe5ea60d15a565df61b62d912dd8aa9b7f65d, host: vibespot.fra1.digitaloceanspaces.com, Authorization: AWS4-HMAC-SHA256 Credential=DK2R2J6XYEQMMPLSFBUF/20211226/fra1/s3/aws4_request, SignedHeaders=content-length;content-type;host;x-amz-acl;x-amz-content-sha256;x-amz-date, Signature=875be7b6828825d30ab59bbb98d2f710fae953449bae1e5105e9b78ea3f00194}
    