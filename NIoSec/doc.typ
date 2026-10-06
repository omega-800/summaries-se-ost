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

#shared.ciphersuites

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

The Heartbeat extension is a keep-alive feature of TLS. The `heartbeat_request`
message includes payload length, payload and padding fields. The Heartbleed bug
is an implementation flaw in that extension.

+ Send message that indicates the maximum payload length (64 KB) that only
  includes the minimum payload (16 bytes)
+ Receive almost 64 KB of random memory that the server returns
+ Profit (look for private keys, auth cookies, etc.)

Countermeasures: Update OpenSSL

=== Syn Flooding

Idea: Fill the TCB (Transmission Control Block) queue storing the half-open
(never ACKed) TCP connections so that there will be no space to store TCB for
any new half-open connections. Basically the server cannot accept any new SYN
packets.

+ Use random source IP addresses; otherwise the attacks may be blocked by the
  firewalls.
+ Spam TCP requests
+ Profit (sleep well knowing you're a menace to society)

The SYN+ACK packets sent by the server may be dropped because forged IP address
may not be assigned to any machine. If it does reach an existing machine, a RST
packet will be sent out, and the TCB will be dequeued.

Countermeasures: SYN Cookies
- After a server receives a SYN packet, it calculates a keyed hash (H) from the
  information in the packet using a secret key that is only known to the server.
- This hash (H) is sent to the client as the initial sequence number from the
  server. H is called SYN cookie.
- The server will not store the half-open connection in its queue.
- If the client is an attacker, H will not reach the attacker.
- If the client is not an attacker, it sends H+1 in the acknowledgement field.
- The server checks if the number in the acknowledgement field is valid or not
  by recalculating the cookie.

=== TCP Reset

Spoof RST Packet to break up a TCP connection between Alice and Bob.

The following fields need to be set correctly: Source IP address, Source Port,
Destination IP address, Destination Port, Sequence number (within the receiver’s
window)

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

#todo[W2 slides 18]

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
/ Message Authentication Codes (MAC): Provides authentic channel over an
  insecure channel (a short piece of information used for authenticating and
  integrity-checking a message, like a signature but symmetric). Vulnerable to
  length-extension-attacks.
/ Cryptographic hash function: Should be collision-resistant and one-way.
  #tg[Good: SHA2, SHA3], #tr[Bad: MD5, SHA-1]
/ Symmetric Encryption: Provides secure channel over an authentic channel
/ Hash-based MAC (HMAC): Fixes length-extension-attack vulnerability.
  $ "Hash"("key" xor "opad" | "Hash" ("key" xor "ipad" | m)) $
/ Block Size: Size of transformed/compressed data in the hash function for each
  iteration.
/ Message Digest Size: The output size of the hash function, also called hash
  value.

=== Block Cipher

#shared.blockcipher.desc

==== Electronic Code Block (ECB)

#shared.blockcipher.ecb

==== Cipher Block Chaining (CBC)

#shared.blockcipher.cbc

=== Stream Cipher

#shared.streamcipher

=== Overall Construction

#align(center, diagram(
  node((0, 0), " ", shape: key.with(label: [M]), width: 3em, height: 1.5em),
  edge("-|>"),
  node((1, 0), "Insecure Channel", fill: colors-l.red),
  edge("-|>"),
  node((2, 0), " ", shape: key.with(label: [V]), width: 3em, height: 1.5em),
  node((1, .75), "Message Authentication Protocol", stroke: none),
  node((4, 0), $->$, stroke: none),
  node((5, 0), "Authentic Channel", fill: colors-l.darkblue),

  node((0, 2), " ", shape: key.with(label: [E]), width: 3em, height: 1.5em),
  edge("-|>"),
  node((1, 2), "Authentic Channel", fill: colors-l.darkblue),
  edge("-|>"),
  node((2, 2), " ", shape: key.with(label: [D]), width: 3em, height: 1.5em),
  node((1, 2.75), "Symmetric Encryption Protocol", stroke: none),
  node((4, 2), $->$, stroke: none),
  node((5, 2), "Secure Channel", fill: colors-l.green),

  node((-1, 4), " ", shape: key.with(label: [E]), width: 3em, height: 1.5em),
  edge("-|>"),
  node((0, 4), " ", shape: key.with(label: [M]), width: 3em, height: 1.5em),
  edge("-|>"),
  node((1, 4), "Insecure Channel", fill: colors-l.red),
  edge("-|>"),
  node((2, 4), " ", shape: key.with(label: [V]), width: 3em, height: 1.5em),
  edge("-|>"),
  node((3, 4), " ", shape: key.with(label: [D]), width: 3em, height: 1.5em),
  node((4, 4), $->$, stroke: none),
  node((5, 4), "Secure Channel", fill: colors-l.green),
))

/ Authenticity: E.g. HMAC-SHA256
/ Confidentiality: E.g. AES-CBC
/ Authenticity & Confidentiality: E.g. HMAC-SHA256-AES-CBC, AES-GCM

== Asymmetric Cryptography

=== Signature Schemes

*Private key* used to *sign* messages. *Public key* used to *verify* signature.
Signatures provide authenticity and non-repudiation. Examples: RSA, DSA, ECDSA

Signing is (often) computationally heavy. Some signature schemes natively only
support small messages (naive RSA). Solution: Sign the hash of the message
instead of the message itself

=== Public Key Infrastructure (PKI)

#shared.pki.components

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

#tg[Good pratice:] Ephemeral keys, randomly generated for each session. Provides
Independence between sessions and limits impact if compromised.

#tr[Problem:] Authenticity, you need to know with whom we agree on a key,
otherwise MitM possible. One cannot use MACs (no shared key available).

/ Key Exchange Protocol (KEX): Both parties contribute to the key, often the
  same protocol for both parties (e.g. DH KEX)
/ Key Encapsulation Mechanism (KEM): One party generates the key, Key is wrapped
  (= encrypted) and sent to the other party #todo[W2 diagram slides 46]

==== Diffie-Hellmann

#shared.diffiehellman

=== Asymmetric Encryption

- Public key used to encrypt messages
- Private key used to decrypt messages

E.g. RSA (factorization) or ElGamal (discrete logarithm)

#todo[W2 slides 48,51]

=== Overall Construction

#align(center, diagram(
  node((0, 0), [S]),
  edge("-|>"),
  node((1, 0), "Insecure Channel", fill: colors-l.red),
  edge("-|>"),
  node((2, 0), [V]),
  node((1, .75), "Signature Authentication Protocol", stroke: none),
  node((4, 0), $->$, stroke: none),
  node((5, 0), "Expensive Authentic Channel", fill: colors-l.darkblue),

  node((0, 2), [K]),
  edge("-|>"),
  node((1, 2), "E. Authentic Channel", fill: colors-l.darkblue),
  edge("-|>"),
  node((2, 2), [K]),
  node((1, 2.75), "KEX/KEM Protocol", stroke: none),
  node((4, 2), $->$, stroke: none),
  node((5, 2), "Shared Secret Key", fill: colors-l.green),

  node((1, 4), "Shared Secret Key", fill: colors-l.green),
  edge("-|>", (0, 5), corner: left),
  edge("-|>", (2, 5), corner: right),
  node((0, 5), [ADAE]),
  edge("-|>"),
  node((1, 5), "Insecure Channel", fill: colors-l.red),
  edge("-|>"),
  node((2, 5), [ADAE]),
  node((1, 5.75), "Authenticated Encryption Protocol", stroke: none),
  node((4, 5), $->$, stroke: none),
  node((5, 5), "Secure Channel", fill: colors-l.green),
))

== Maths \<3

#todo[W2, merge with DigCod]

== Quantum Cryptography

/ Quantum Cryptography: Using quantum effects to do cryptography, All parties
  have access to quantum systems. Example: Quantum Key Exchange BB84
/ Post-Quantum Cryptography: Cryptography secure even if quantum computers
  exist, the adversary has access to a quantum computer, honest parties are
  (often) classic. Example: ML-KEM

#todo[W3, S9 key length]

A big enough quantum computer could
- #tr[break] known *asymmetric* schemes (Shor algorithm) e.g. RSA (factoring)
  and ElGamal, DH, ECDSA (discret log.)
- #tg[not break] *symmetric* schemes e.g. Hash functions (SHA-2) and AES-256

=== Quantum Key Distribution

QKD's security is based on physical properties of quantum systems instead of
hard math problems.

=== BB84 (By example of polarized light)

#{
  let nd = node.with(
    height: 1em,
    width: 1em,
    inset: 2pt,
  )
  let ndn = nd.with(stroke: none)
  let ndb = nd.with(height: 2em, width: 2em)
  let pv(p) = nd(
    p,
    shape: fletcher.shapes.circle,
    text(size: 2em, { sym.arrow.l.r }),
  )
  let ph(p) = nd(
    p,
    shape: fletcher.shapes.circle,
    text(size: 2em, { sym.arrow.t.b }),
  )
  let pd(p) = nd(
    p,
    shape: fletcher.shapes.circle,
    text(size: 2em, { rotate(45deg, sym.arrow.l.r) }),
  )
  let gv(p) = ndb(
    p,
    shape: fletcher.shapes.rect,
    text(size: 2em, { sym.times }),
  )
  let gh(p) = ndb(
    p,
    shape: fletcher.shapes.rect,
    text(size: 2em, { sym.plus }),
  )
  let edge = edge.with("-|>")
  diagram(
    ndn((-1, 1), [A]),
    ndn((9, 1), [B]),
    ndn((0, 0), [1]),
    edge(),
    gh((2, 0)),
    edge(),
    ph((4, 0)),
    edge(),
    gh((6, 0)),
    edge(),
    ndn((8, 0), [1]),

    ndn((0, 2), [0]),
    edge(),
    gh((2, 2)),
    edge(),
    pv((4, 2)),
    edge(),
    gh((6, 2)),
    edge(),
    ndn((8, 2), [0]),
  )

  h(2em)

  diagram(
    pd((4, 0)),
    edge(),
    gh((6, 0)),
    edge((10, -1), label: "50%"),
    edge((10, 1), label: "50%"),
    pv((10, -1)),
    edge(),
    ndn((12, -1), [1]),
    ph((10, 1)),
    edge(),
    ndn((12, 1), [0]),
  )

  h(2em)

  diagram(
    ndn((0, 0), [b]),
    edge(),
    gh((2, 0)),
    edge(),
    gh((6, 0)),
    edge(),
    ndn((8, 0), [b]),

    ndn((0, 2), [b]),
    edge(),
    gv((2, 2)),
    edge(),
    gv((6, 2)),
    edge(),
    ndn((8, 2), [b]),

    ndn((0, 4), [b]),
    edge(),
    gv((2, 4)),
    edge(),
    gh((6, 4)),
    edge(),
    ndn((8, 4), [?]),

    ndn((0, 6), [b]),
    edge(),
    gh((2, 6)),
    edge(),
    gv((6, 6)),
    edge(),
    ndn((8, 6), [?]),
  )
}

/ No cloning theorem: One cannot duplicate photons. This prevents the idea of
  duplication and then measuring one while sending the other along.
/ Simplified protocol: For $1..k$:
  + Alice selects random bit $b$
  + Alice sends $b$ using random base (+ or x)
  + Bob measures photon with random base (+ or x)
  Bob and Alice exchange information on used bases over authentic channel
  - They know which photons Bob measured correctly
  - They have a common bit-string
  - Errors imply listeners

#todo[Eavesdropping creates noise (W3 S35..)]

= IPsec

A collection of protocols that allow secure communication over IP networks.
Provides confidentiality and/or authenticity and integrity of (parts of) IP
packets.

== Protocols

A collection of protocols that allow secure communication over IP networks:

/ Security Architecture for the Internet Protocol: #rfc(4301) Defines basic
  architecture and requirements for IPsec gateways. In particular: Security
  Associations Management, e.g. "MUST support ESP", z.B. "MAY support AH"
/ Authentication Header (AH): #rfc(4302) Protocol to protect the
  integrity/authenticity of both payload and header data
/ Encapsulating Security Payload (ESP): #rfc(4303) Protocol to protect the
  confidentiality and integrity/authenticity of payload data
/ Internet Key Exchange v2 (IKEv2): #rfc(7296) Protocol for manual and automated
  key exchange \ Relevant for creating Security Associations used in AH and ESP

=== Authentication Header (AH)

Protects the integrity/authenticity of the payload and parts of the IP header
(#tp[purple]). Provides (optional) replay protection, does not provide
confidentiality.

Protocol Field in the IP header: 0x33

#let sargs = (fill: colors-l.purple)

Protected IP Header:
#frame(
  (
    Version: (args: sargs, size: 4),
    IHL: (args: sargs, size: 4),
    DSCP: (args: sargs, size: 6),
    ECN: (args: sargs, size: 2),
    "Total Length": (args: sargs, size: 16),
  ),
  (
    Identification: (args: sargs, size: 16),
    RS: (size: 1),
    DF: (size: 1),
    MF: (size: 1),
    "Fragment Offset": (size: 13),
  ),
  (
    "Time to Live": (size: 8),
    "Protocol": (args: sargs, size: 8),
    "Header Checksum": 16,
  ),
  ("Source IP Address": (args: sargs, size: 32)),
  ("Destination IP Address": (args: sargs, size: 32)),
  ("Options (if IHL > 5)": (size: 32)),
)

IP Packet with AH:

#grid(
  columns: (1fr, 1fr, 4fr),
  stroke: 1pt,
  gutter: 0pt,
  inset: .5em,
  grid.cell(stroke: none)[],
  grid.cell(
    stroke: none,
    colspan: 2,
  )[$stretch(<->, size: #900%)^"authenticated"$],
  [IP Header], [AH], [Payload],
)

Authentication Header:

#frame(
  (
    "Next Header": (
      size: 8,
      desc: "ID of the protocol of the payload (eg. TCP/UDP)",
    ),
    "Payload Len": 8,
    "RESERVED": (size: 16, desc: "All zeroes"),
  ),
  (
    "Security Parameters Index (SPI)": (
      size: 32,
      desc: [Identifies the Security Association (SA), which in turn defines
        security attributes like Keys and Authentication algorithms],
    ),
  ),
  ("Sequence Number Field": (desc: "For replay protection", size: 32)),
  (
    "Integrity Check Value - ICV (variable)": (
      desc: "e.g. HMAC_SHA2_512_256",
      size: 32,
    ),
  ),
)

The sender increments the sequence number by one for every packet sent., the
receiver stores the highest sequence number received so far.
- Too old or already received packets are rejected
- "Too old" is defined via the anti-replay window (default: 64)
The sequence number (32-bit value) is tracked per security association (SA)
- max 232-1 packets can be sent per SA
- Periodically a new SA is built
Extended Sequence Numbering are 64-bit values used for high-speed connections
(>100 Gbps)

=== Encapsulating Security Payload (ESP)

Provides Confidentiality and authenticity of the payload. Authenticity (via ICV)
and replay protection is optional (but recommended).

The IP header is not protected. Protocol Field in the IP header: 0x34

#grid(
  columns: (1fr, 1fr, 2fr, 1fr, 1fr),
  stroke: 1pt,
  gutter: 0pt,
  inset: .5em,
  grid.cell(stroke: none)[],
  grid.cell(
    stroke: none,
    colspan: 4,
  )[$stretch(<->, size: #900%)^"authenticated"$],
  [IP Header], [ESP-Header], [Payload], [ESP-Trailer], [ESP-ICV],
  grid.cell(stroke: none, colspan: 2)[],
  grid.cell(stroke: none, colspan: 2)[$stretch(<->, size: #750%)_"encrypted"$],
  grid.cell(stroke: none)[],
)

#todo[W3 S14]
