import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dospace/dospace.dart' as dospace;
import 'package:http/http.dart' as http;

import 'env.dart';

const String region = Env.region;
const String accessKey = Env.accessKey;
const String secretKey = Env.secretKey;
const String bucketName = Env.bucketName;

main() async {
  print(Platform.environment['use']);
  dospace.Spaces spaces = new dospace.Spaces(
    region: region,
    accessKey: accessKey,
    secretKey: secretKey,
  );
  for (String name in await spaces.listAllBuckets()) {
    print('bucket: ${name}');
    dospace.Bucket bucket = spaces.bucket(name);
    // await for (dospace.BucketContent content
    //     in bucket.listContents(maxKeys: 3)) {
    //   print('key: ${content.key}');
    // }
  }
  // print(await File('destmond.jpeg').exists());
  dospace.Bucket bucket = spaces.bucket(bucketName);
  String? etag = await bucket.uploadFile('destmond.jpeg', File('destmond.jpeg'),
      'image/jpeg', dospace.Permissions.public);

  print('upload: $etag, ${bucket.endpointUrl}/destmond.jpeg');

  // var r = await bucket.delete('destmond.jpeg');
  // print('delete: $r');

  // String? etag2 = await bucket.uploadFile('lesson.mp4', File('lesson.mp4'),
  //     'video/mp4', dospace.Permissions.public);
  // print('upload: $etag2, ${bucket.endpointUrl}/lesson.mp4, ${DateTime.now()}');

  // Basic pre-signed URL
  print('list buckets: ${spaces.preSignListAllBuckets()}');

  // Basic pre-signed upload
  {
    String preSignUrl = bucket.preSignUpload('destmond3.jpeg')!;
    print('upload url: ${preSignUrl}');
    var httpClient = new http.Client();
    var httpRequest = new http.Request('PUT', Uri.parse(preSignUrl));
    http.StreamedResponse httpResponse = await httpClient.send(httpRequest);
    String body = await utf8.decodeStream(httpResponse.stream);
    print('${httpResponse.statusCode} ${httpResponse.reasonPhrase} ');
    print(httpResponse.stream);
    httpClient.close();
  }

  // Pre-signed upload with specific payload
  {
    var input = new File('destmond.jpeg');
    int contentLength = await input.length();
    Digest contentSha256 = await sha256.bind(input.openRead()).first;
    String preSignUrl = bucket.preSignUpload('destmond2.jpeg',
        contentLength: contentLength, contentSha256: contentSha256)!;
    print('strict upload url: ${preSignUrl}');
    var httpClient = new http.Client();
    var httpRequest = new http.Request('PUT', Uri.parse(preSignUrl));
    http.StreamedResponse httpResponse = await httpClient.send(httpRequest);
    String body = await utf8.decodeStream(httpResponse.stream);
    print('${httpResponse.statusCode} ${httpResponse.reasonPhrase}');
    print(body);
    httpClient.close();
  }

  print('done');
}
