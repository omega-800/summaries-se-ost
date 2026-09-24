#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Introduction

OSI Stack:
#table(
  columns: (auto, 1fr),
  [Communication layers], [Security protocols],
  [Application layer], [Web Application Security, VoIP Security, SW Security],
  [Transport layer], [TLS ],
  [Network layer], [IPsec],
  [Data Link layer], [L2TP, IEEE 802.1X, IEEE 802.1AE, IEEE 802.11i (WPA2)],
  [Physical layer], [Quantum Key Exchange],
)

The CIA triad is a foundational information-security model stating that systems
should protect:
/ Confidentiality: Keeping information secret
/ Integrity: Keeping information correct and unaltered
/ Availability: Ensuring information and systems remain accessible

Additional desired properties include:
/ Authenticity: Adversary cannot claim to be someone else
/ Accountability/Non-repudiation: Actions can be traced to actor

= TLS

SSL and TLS are protocols for internet handshakes and encrypted transmission.
Secure Socket Layer (SSL) came first, then after v3.0 it became Transport Layer
Security (TLS), currently v1.3. People still use SSL as a term, even though
technically it’s now TLS.

/ TLS 1.2: Introduced authenticated encryption, which is the most modern form of
  encryption. It's a more flexible protocol, lots of TLS extensions, the hashing
  function has been improved.
/ TLS 1.3: The protocol has been redesigned to make it faster. A lot of the old
  ciphers have been removed to make it more secure. It only supports
  authenticated encryption (AEAD).

#todo[W1 slides 22]

== Specification

#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: center,
  fill: colors-l.darkblue,
  gutter: 5pt,
  inset: 5pt,
  [Handshake],
  [Cipher Change Spec],
  [Alert],
  [Application Data],
  grid.cell(colspan: 4)[Record Protocol],
)

=== Record protocol

All TLS packets are sent using the record protocol. This header is attached to
every single message.

#custom-frame(
  columns: (1fr, 2fr, 2fr, 2fr),
  table.cell(colspan: 3)[Header],
  table.cell(colspan: 1)[Data],
  [Type (1B)],
  [Version (2B)],
  [Length (2B)],
  [...],
)

/ Type: which kind of TLS message is sent (20,21,22,23)
/ Version: which TLS version is used
/ Length: how long is the payload of the message

=== Subprotocols

#deftbl(
  term: "Protocol",
  [20 ChangeCipherSpec],
  [
    The sender has sufficient information and is switching to encryption or to a
    new cipher suite (sent very rarely).

    By starting encryption for the first time, it is saying that the handshake
    has been successful, and encryption can start
  ],
  [21 Alert],
  [
    An SSL-level alert notification (example close_notify). Not necessarily an
    error. Example: problem with the handshake, received data length is wrong,
    warning.
  ],
  [22 Handshake],
  [
    Messages sent right at the beginning (example ServerKeyExchange). Eg. To
    establish a cipher, to establish our keys
  ],
  [23 Application Data],
  [
    Opaque application data. Any applications data once we start the encryption
    is going to be sent under protocol 23
  ],
)

=== Handshake

#grid(
  columns: 3,
  [], align(center)[TLS 1.2], align(center)[TLS 1.3],
  [
    The TLS handshake protocol is used to establish parameters for the remainder
    of the session. It must:

    - Agree ciphers and protocols
    - Establish shared secrets
    - Authenticate server and client
    - Be robust to tampering and attacks
  ],
  seqdiag({
    _par("Client")
    _par("Server")

    _seq("Client", "Server", comment: "Hello")
    _seq("Server", "Client", comment: "Hello")
    _seq("Client", "Server", comment: [Key Share, Change\ cipher spec,
      Finished])
    _seq("Server", "Client", comment: [Change cipher spec,\ Finished])
    _seq(
      "Client",
      "Server",
      slant: 0,
      dashed: true,
      start-tip: ">",
      end-tip: ">",
      comment: "Data",
    )
  }),

  seqdiag({
    _par("Client")
    _par("Server")

    _seq("Client", "Server", comment: "Hello, Key Share")
    _seq("Server", "Client", comment: [Key Share, Certificate\ verify,
      Finished])
    _seq(
      "Client",
      "Server",
      slant: 0,
      dashed: true,
      start-tip: ">",
      end-tip: ">",
      comment: "Data",
    )
  }),
)

== Modern TLS Variants

=== DTLS

#grid(
  columns: (1fr, auto),
  [
    - TLS on top of UDP
    - Used for WebRTC, VoIP
    - Does not provide ordering of packets
    - Packets may drop, retransmission is delegated to application
  ],
  grid(
    align: center,
    fill: colors-l.darkblue,
    gutter: 3pt,
    inset: 3pt,
    [WebRTC/VoIP],
    grid.cell(fill: colors-l.purple)[DTLS],
    [UDP],
    [IP],
  ),
)

=== QUIC

#grid(
  columns: (1fr, auto),
  [
    - TLS 1.3 + UDP
    - Provides reliable communication
      - Stateful
      - Multiple streams
    - Used for HTTP/3, RPC
  ],
  grid(
    align: center,
    fill: colors-l.darkblue,
    gutter: 3pt,
    inset: 3pt,
    [HTTP/3, RPC],
    grid.cell(fill: colors-l.purple)[QUIC],
    [UDP],
    [IP],
  ),
)

== Attacks

=== Heartbleed

The Heartbeat extension is a keep-alive feature of TLS.
The `heartbeat_request` message includes payload length, payload and padding
fields.
The Heartbleed bug is an implementation flaw in that extension.

+ Send message that indicates the maximum payload
  length (64 KB) that only includes the minimum
  payload (16 bytes)
+ Receive almost 64 KB of random memory that the server returns
+ Profit (look for private keys, auth cookies, etc.)

Countermeasures: Update OpenSSL

=== Syn Flooding

Idea: Fill the TCB (Transmission Control Block) queue storing the half-open
(never ACKed) TCP connections so that there will be no space
to store TCB for any new half-open connections. Basically the server cannot
accept any new SYN packets.

+ Use random source IP addresses; otherwise the attacks may be blocked by the firewalls.
+ Spam TCP requests
+ Profit (sleep well knowing you're a menace to society)

The SYN+ACK packets sent by the server may be dropped because forged IP address may
not be assigned to any machine. If it does reach an existing machine, a RST packet will be
sent out, and the TCB will be dequeued.

Countermeasures: SYN Cookies
- After a server receives a SYN packet, it calculates a keyed hash (H) from the information in
  the packet using a secret key that is only known to the server.
- This hash (H) is sent to the client as the initial sequence number from the server. H is called
  SYN cookie.
- The server will not store the half-open connection in its queue.
- If the client is an attacker, H will not reach the attacker.
- If the client is not an attacker, it sends H+1 in the acknowledgement field.
- The server checks if the number in the acknowledgement field is valid or not by recalculating
  the cookie.

=== TCP Reset

Spoof RST Packet to break up a TCP connection between Alice and Bob.

The following fields need to be set correctly:
Source IP address, Source Port,
Destination IP address, Destination Port,
Sequence number (within the receiver’s window)

=== FREAK

- Man-in-the-middle (MitM) downgrades used TLS cipher suite to use export RSA
- MitM then factors 512 bit RSA to get session key

#todo[https://ciphersuite.info/cs/TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256/]

= Cryptography

/ Parties: The abstract entities in cryptographic protocols (servers, switches,
  humans)
/ Attacker model: Defines the capabilities of the attacker (computational
  limits, corruption)
/ Secure channel: Provides Confidentiality (we allow length leakage) and
  Authenticity (we don't care about liveness)
/ Authentic channel: Only provides Authenticity

== Protocols

#todo[slides 18]

== Standards

Don't roll your own crypto, except if you work at FAANG, they shall perish.

National Institute of Standards and Technology (NIST) publishes
- Special Publications (SP), guidelines and recommendations
- Federal Information Processing Standards (FIPS), standards for US government
Internet Society (ISOC)
- Organizes working groups for TCP/IP
- Publishes RFCs

== Symmetric-Key Cryptography

/ Insecure channel: Vulnerable to MITM Attacks
/ Shared key: Secure means the adversary has no information about the shared
  key. Establishing a shared key is non-trivial
  - Pre-shared key (Code book)
  - Quantum key exchange
  - Public Key Cryptography
/ Message Authentication Codes (MAC): Provide authentic channel over an insecure
  channel #todo[slides 26]
/ Cryptographic hash function: Should be collision-resistant and one-way.
  #tg[Good: SHA2, SHA3], #tr[Bad: MD5, SHA-1]
/ Symmetric Encryption: Provides secure channel over an authentic channel

=== Hash-based MAC (HMAC)

#todo[slides 28]

=== Block Cipher

#todo[slides 31,32, merge with CySec]

=== Stream Cipher

#todo[slides 33,34, merge with CySec]

=== Authenticated Encryption

#todo[slides 35]

== Asymmetric Cryptography

=== Signature Schemes

- Public Key / Asymmetric
  - Private key used to sign messages
  - Public key used to verify signature
- Signatures provide authenticity and non-repudiation
- Examples: RSA, DSA, ECDSA

#todo[slides 40]

=== Public Key Infrastructure (PKI)

Each party has a private key and every other party knows their public key, e.g.
via a registry. X.509 certificates and Certificate Authorities (CA) are used.

PKI provides an authentic channel over an insecure channel.

=== Signatures vs MACs

#table(
  columns: (1fr, 1fr),
  [Signatures], [MACs],
  [Authenticity, non-repudiation], [Authenticity only (key shared)],
  [Slow (asymmetric)], [Fast (symmetric)],
  [Often: Use with long term keys], [Often: Used with ephemeral keys],
)

=== Establishing a shared key

Has to be established over an authentic channel.

Good pratice: Ephemeral keys, randomly generated for each session. Provides
Independence between sessions and limits impact if compromised.

Problem: Authenticity, you need to know with whom we agree on a key,
otherwise MitM possible. One cannot use MACs (no shared key available).

/ Key Exchange Protocol (KEX): Both parties contribute to the key, often the
  same protocol for both parties (e.g. DH KEX)
/ Key Encapsulation Mechanism (KEM): One party generates the key, Key is wrapped
  (= encrypted) and sent to the other party #todo[diagram slides 46]

#todo[slides 47,48 merge with CySec]

=== Asymmetric Encryption

- Public key used to encrypt messages
- Private key used to decrypt messages

E.g. RSA (factorization) or ElGamal (discrete logarithm)

#todo[slides 50]

#todo[Overall Construction Idea]

== Maths \<3

#todo[]

