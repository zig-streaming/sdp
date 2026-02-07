# SDP

Zig implementation of the Session Description Protocol (SDP).

Related RFC:
    
* [RFC 4566](https://datatracker.ietf.org/doc/html/rfc4566): Session Description Protocol.

## Usage

```zig
const std = @import("std");
const SDP = @import("sdp");

const sdp_text =
    \\v=0
    \\o=jdoe 2890844526 2890842807 IN IP4 10.47.16.5
    \\s=SDP Seminar\r\n\
    \\i=A Seminar on the session description protocol
    \\u=http://www.example.com/seminars/sdp.pdf
    \\e=j.doe@example.com (Jane Doe)
    \\p=+1 617 555-6011
    \\c=IN IP4 224.2.17.12/127
    \\b=X-YZ:128
    \\b=AS:12345
    \\t=2873397496 2873404696
    \\t=3034423619 3042462419
    \\r=604800 3600 0 90000
    \\z=2882844526 -3600 2898848070 0
    \\k=prompt
    \\a=candidate:0 1 UDP 2113667327 203.0.113.1 54400 typ host
    \\a=recvonly
    \\m=audio 49170 RTP/AVP 0
    \\i=Vivamus a posuere nisl
    \\c=IN IP4 203.0.113.1
    \\b=X-YZ:128
    \\k=prompt
    \\a=sendrecv
    \\m=video 51372 RTP/AVP 99
    \\a=rtpmap:99 h263-1998/90000
    \\
;

var sdp = try SDP.parse(sdp_text);

var attribute_iterator = sdp.attributeIterator();
while (try attribute_iterator.next()) |attribute| {
    // Do something with the session-level attribute.
}

var media_iterator = sdp.mediaIterator();
while (try media_iterator.next()) |media| {
    // Do something with the media description.
    attribute_iterator = media.attributeIterator();
    while (try attribute_iterator.next()) |attribute| {
        // Do something with the media-level attribute.
    }
}
```