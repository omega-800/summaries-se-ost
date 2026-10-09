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

Protects the #highlight(fill: colors-l.darkblue)[integrity/authenticity] of the payload and parts of the IP header
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

#{
  set text(font: code-font, size: .9em)
  show "Authenticated": highlight.with(fill: colors-l.darkblue)
  align(center, diagram(
    spacing: (0pt, 1em),
    edge((0.5, 0), (3, 0), "->", label: "Authenticated"),
    edge((-1, 0), (.5, 0), "<.."),
    node((0, 1), width: 8em)[IP Header],
    node((1, 1), width: 8em)[AH],
    node((2, 1), width: 16em)[Payload],
  ))
}

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
- #todo[max 232-1 packets can be sent per SA]
- Periodically a new SA is built
Extended Sequence Numbering are 64-bit values used for high-speed connections
(>100 Gbps)

=== Encapsulating Security Payload (ESP)

Provides #highlight(fill: colors-l.green)[Confidentiality and authenticity] of the payload. Authenticity (via ICV)
and replay protection is optional (but recommended).

The IP header is not protected. Protocol Field in the IP header: 0x34

#{
  set text(font: code-font, size: .9em)
  show "Authenticated": highlight.with(fill: colors-l.darkblue)
  show "Encrypted": highlight.with(fill: colors-l.green)
  align(center, diagram(
    spacing: (0pt, 1em),
    edge((0.5, 0), (5, 0), "<->", label: "Authenticated"),
    edge((1.325, 2), (3.5, 2), "<->", label: "Encrypted"),
    node((0, 1), width: 8em)[IP Header],
    node((1, 1), width: 8em)[ESP-Header],
    node((2, 1), width: 16em)[Payload],
    node((3, 1), width: 8em)[ESP-Trailer],
    node((4, 1), width: 8em)[ESP-ICV],
  ))
}

#todo[W3 S14]

== Modes of Operation

=== Transport vs. Tunnel Mode

Both AH and ESP have two modes of operation:
/ Transport Mode: Protects IP packets directly
/ Tunnel Mode: IP packets are packed into a new IP packet (as payload) which is then protected

#{
  set text(font: code-font, size: .9em)
  show "Authenticated": highlight.with(fill: colors-l.darkblue)
  show "Encrypted": highlight.with(fill: colors-l.green)
  grid(
    columns: 1,
    emph[Transport],
    diagram(
      spacing: (0pt, 1em),
      edge((0.5, 0), (3, 0), "->", label: "Authenticated"),
      edge((-1, 0), (.5, 0), "<.."),
      node((0, 1), width: 8em)[IP Header],
      node((1, 1), width: 8em)[AH],
      node((2, 1), width: 10em)[Payload],
    ),
    diagram(
      spacing: (0pt, 1em),
      edge((0.5, 0), (5, 0), "<->", label: "Authenticated"),
      edge((1.45, 2), (3.5, 2), "<->", label: "Encrypted"),
      node((0, 1), width: 8em)[IP Header],
      node((1, 1), width: 8em)[ESP-Header],
      node((2, 1), width: 10em)[Payload],
      node((3, 1), width: 8em)[ESP-Trailer],
      node((4, 1), width: 8em)[ESP-ICV],
    ),
    emph[Tunnel],
    diagram(
      spacing: (0pt, 1em),
      edge((-.5, 0), (3, 0), "->", label: "Authenticated"),
      edge((-2, 0), (-.5, 0), "<.."),
      node((-1, 1), width: 8em)[new IP H.],
      node((0, 1), width: 8em)[AH],
      node((1, 1), width: 8em)[IP Header],
      node((2, 1), width: 10em)[Payload],
    ),
    diagram(
      spacing: (0pt, 1em),
      edge((-0.5, 0), (5, 0), "<->", label: "Authenticated"),
      edge((0.5, 2), (3.5, 2), "<->", label: "Encrypted"),
      node((-1, 1), width: 8em)[new IP H.],
      node((0, 1), width: 8em)[ESP-Header],
      node((1, 1), width: 8em)[IP Header],
      node((2, 1), width: 10em)[Payload],
      node((3, 1), width: 8em)[ESP-Trailer],
      node((4, 1), width: 8em)[ESP-ICV],
    ),
  )
}

=== Transport Mode

- The IP traffic is intended for the IPsec endpoints
- End-to-end security, but transparent for applications
- ESP: secure channel
- AH: authentic channel

=== ESP Tunnel Mode

/ Site-to-Site VPN:
  - Tunnel between two IPsec gateways
  - Transparent for endpoints. Independent of application
  - Internal IP addresses remain confidential
  - E.g. VPN tunnel between corporate networks

/ Client-to-Site VPN:
  - Tunnel between an IPsec client and an IPsec gateway
  - Internal IP addresses remain confidential
  - E.g. Remote access to corporate network

== Security Associations

For IPsec communication the peers need to share information on
- Cipher Suite, Key Length, Keys, ...
- Protocol: AH or ESP
- Mode: Transport or Tunnel
- Sequence number counter
- Validity period of security associations

This information is stored in a security association (SA),
Identified by a Security Parameters Index (SPI).
Separate SAs for each communication direction, i.e. one per sender, and separate
SAs for AH and ESP.

=== SAD and SPD

/ Security Policy Database (SPD): decides how to handle an IP packet
  - Decision: #tr[Discard], #tg[Bypass], #to[Protect]
  - Based on selectors: IP addresses, Next Layer Protocol, ...
/ Security Association Database (SAD): holds all the security associations
  - Incoming packets: SPI and possibly IP address point to SAD entry
  - Outgoing packets: SPD entry points to SA

=== Handling of outbound packets

#let (start, end, decide, desc, next, yes, no) = fletcher-state-diag-elems(
  height: 3em,
  width: 8em,
)
#align(center, diagram(
  spacing: (5em, 4em),
  start((0, 0), [Outbound\ IP packet]),
  next(),
  decide((1, 0), [Match found\ in SPD?]),
  no((0, 1)),
  yes(),
  decide((1, 1), [Determine\ Policy]),
  next(stroke: colors.red, label: tr[DISCARD], bend: 20deg),
  next((2, 1), stroke: colors.orange, label: to[PROTECT], bend: -20deg),
  next((1, 2), stroke: colors.green, label: tg[BYPASS]),
  end((0, 1), [Discard\ Packet]),
  decide((2, 1), [Match found\ in SAD?]),
  no(bend: 20deg),
  yes((2, 2)),
  desc((2, 0), [Internet key\ exchange]),
  next((2, 1), bend: 20deg),
  desc((2, 2), [Process\ (AH/ESP)]),
  next(),
  end((1, 2), [Forward packet\ via IP]),
))

=== Handling of inbound packets

#align(center, diagram(
  spacing: (5em, 4em),
  start((0, -1), [Inbound\ IP packet]),
  next(),
  decide((0, 0), [Packet type?]),
  next(label: [IP]),
  next((1, 1), label: [IPsec]),
  decide((1, -1), [BYPASS\ in SPD?]),
  no((1, 0)),
  yes((2, 0)),
  decide((1, 1), [Match\ in SAD?]),
  no(),
  yes((2, 1), bend: 20deg),
  end((1, 0), [Discard\ packet]),
  desc((2, 1), [Process\ (AH/ESP)]),
  next(),
  end((2, 0), [Deliver packet\ to higher layer]),
))

#todo[W4 S25,26]

== Internet Key Exchange v2 (IKEv2)

#todo[W4 S29 diagram]

Protocol for mutual authentication and building of security
associations between an Initiator and a Responder. #rfc(7296)

Goal: Initiator and Responder each have
- a security association for IKE transport (IKE-SA)
- security associations for ESP or AH traffic (CHILD-SA)

IKE messages are transmitted over UDP (port 500)

=== Initial Exchanges

#seqdiag({
  _par("Initiator")
  _par("Responder")

  _seq("Initiator", "Responder", comment: "IKE_SA_INIT")
  _note("right", grid(
    columns: 2,
    [HDR], [IKE Header, incl. SPI of I],
    [SAi1], [Crypto algorithms supported by I],
    [KEi], [I's Diffie-Hellman value],
    [Ni], [I's Nonce],
  ))
  _seq("Responder", "Initiator", comment: "IKE_SA_INIT")
  _note("right", grid(
    columns: 2,
    [HDR], [IKE Header, incl. SPI of R],
    [SAr1], [Chosen crypto algo (from SAi1)],
    [KEr], [R's Diffie-Hellman value],
    [Nr], [R's Nonce],
  ))
  _grp("Encrypted & Authenticated", {
    _seq("Initiator", "Responder", comment: "IKE_AUTH")
    _note("right", grid(
      columns: 2,
      [HDR], [IKE Header, incl. SPI of I],
      [IDi], [Identity of I],
      [[CERT],], [[CERT-Request]],
      [AUTH], [Signature or MAC],
      [SAi2], [Sup. Crypto Algos for IPsec by I],
      [TSi, TSr], [Traffic selectors],
    ))
    _seq("Responder", "Initiator", comment: "IKE_AUTH")
    _note("right", grid(
      columns: 2,
      [HDR], [IKE Header, incl. SPI of R],
      [IDr], [Identity of R],
      [[CERT]], [],
      [AUTH], [Signature or MAC],
      [SAr2], [Sup. Crypto Algos for IPsec by R],
      [TSi, TSr], [Traffic selectors],
    ))
  })
})

#todo[W4 S30,31]

=== AUTH

In the IKE_AUTH messages

- The identity of peers is verified by means of
  - Signatures (Certificates are sent in the messages)
  - Symmetric MAC if using a pre-shared-key
- The authenticity of the IKE_INIT messages is verified as well
- Instead of AUTH one can use Extensible Authentication (EAP)
  - Initiator omits the AUTH field to indicate this mode
  - Normally used to authenticate an initiator
  - Uses an additional exchange IKE_AUTH messages

=== Child SA Exchange

#seqdiag({
  _par("Initiator")
  _par("Responder")

  _grp("Encrypted & Authenticated", {
    _seq("Initiator", "Responder", comment: "CREATE_CHILD_SA")
    _note("right", grid(
      columns: 2,
      [HDR], [Header],
      [SA], [SA offer],
      [Ni], [Nonce],
      [KEi], [Diffie-Hellman share],
      [TSi,TSr], [Traffic Selectors],
    ))
    _seq("Responder", "Initiator", comment: "CREATE_CHILD_SA")
    _note("right", grid(
      columns: 2,
      [HDR], [Header],
      [SA], [Accepted SA],
      [Nr], [Nonce],
      [KEr], [Diffie-Hellman share],
      [TSi,TSr], [Traffic Selectors],
    ))
  })
})

#todo[W4 S33]

=== INFORMATIONAL

#seqdiag({
  _par("Initiator")
  _par("Responder")

  _grp("Encrypted & Authenticated", {
    _seq("Initiator", "Responder", comment: "INFORMATIONAL")
    _seq("Responder", "Initiator", comment: "INFORMATIONAL")
  })
})

=== Key Derivation (Function)

/ PRF: Pseudo Random Function

IKEv2 uses a PRF to derive key material, the PRF depends on cipher suite, e.g. AES-CMAC.
Inputs to the PRF comes from Existing key material, the Nonce, and DH key exchange (ephemeral key).

#todo[W4 S36]

=== Algorithms

IPsec use various cryptographic algorithms (in IKEv2 negotiated (SAs)).
#rfc(8247) specifies "mandatory-to-implement" algorithms for IKEv2.
#rfc(8221) specifies algorithms for AH. Various RFCS define cipher suites with
the goal of interoperability and a certain level of security, like
#rfc(4308): Cryptographic Suites for IPsec (2005).

#todo[W4 S40]

== IPsec & NAT

In one-to-one NAT, the NAT:
- replaces source address with its public address
- only works with one client

In Port Address Translation (PAT), the NAT:
- replaces source address with its public address
- Replaces (UDP/TCP) source port with unique free port
- Relays incoming packets to the right client based on the port number.

=== Problems

AH is incompatible as IP addresses are authenticated.

In ESP:
- PAT: The payload (UDP/TCP) is encrypted and cannot be changed by the NAT
- One-to-One NAT: TCP (and UDP in IPv6) has checksums that break when swapping out IP

In IKE:
- Using IP addresses as an identifier (IKEv1) causes issues.
- IKE responder needs to accept packets from a non 500 port.

=== NAT-T and IPsec

#rfc(3948): UDP-Encapsulation of IPsec ESP Packets
- UDP-Header between IP-Header and ESP-Header
- Source und destination port: 4500

#rfc(4306): IKEv2 can (implementation optional)
- Detect NAT (NAT_DETECTION_SOURCE_IP and NAT_DETECTION_DESTINATION_IP in INIT-msg)
- Negotiate UDP-Encapsulation for IKE and ESP
- Source und dst. port: 4500, reply to arbitrary port

#todo[W4 S45 diagrams]

= WireGuard

Wireguard is a Fast, Modern, Secure, Free, Open Source, Best, Bestest VPN Tunnel.

== Crypto stack

Symmetric:
- ChaCha20 for symmetric encryption, authenticated with Poly1305, using #rfc(7539)'s AEAD construction
- BLAKE2s for hashing and keyed hashing, described in #rfc(7693)
- SipHash24 for hashtable keys
- HKDF for key derivation, as described in #rfc(5869)
Asymmetric:
- Curve25519 for ECDH, the public and private keys are for DH

#todo[W4 S53..60]

== IKEv2/IPsec vs WireGuard

#table(
  columns: 3,
  table-header([Aspect], [IKEv2/IPSEC], [WireGuard]),
  [Connectivity],
  [Connection-oriented],

  [Connectionless], [On Top Of], [IP (alt. UPD)],
  [UDP], [Configuration Complexity], [Medium],
  [Low (static keys)], [Configuration Possibilities], [Wide],
  [Limited], [Speed], [Fast],
  [Generally faster], [Quantum Resistance], [Yes (Right Config)],
  [Yes (with PSK enabled)],
  [Which one to pick?],
  [Frequent Mobile Roaming, Enterprise and Legacy Hardware, Regulatory Compliance],

  [High-Performance Streaming and Gaming, Simple DIY and Self-Hosted VPNs, Resource-Constrained Hardware],
)
