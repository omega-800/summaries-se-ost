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
#let icon-img = p => icon-size(image(p, height: 1em))

#let keynode = (
  ..args,
  label: none,
  fill: colors.darkblue,
  stroke: colors-l.darkblue,
) => node(
  ..args,
  width: 4em,
  height: 2em,
  shape: key.with(label: label, fill: fill, stroke: stroke),
)

#let dkeynode = keynode
#let pkeynode = keynode.with(fill: colors.purple, stroke: colors-l.purple)
#let rkeynode = keynode.with(fill: colors.red, stroke: colors-l.red)
#let gkeynode = keynode.with(fill: colors.green, stroke: colors-l.green)

= Introduction

OSI Stack:
#table(
  columns: (auto, 1fr),
  [Communication layers], [Security protocols],
  [Application layer], [Web Application Security, VoIP Security, SW Security],
  [Transport layer], [TLS],
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
  keynode((0, 0), label: [M]),
  edge("-|>"),
  node((1, 0), "Insecure Channel", fill: colors-l.red),
  edge("-|>"),
  keynode((2, 0), label: [V]),
  node((1, .75), [Message Authentication\ Protocol], stroke: none),
  node((4, 0), $->$, stroke: none),
  node((5, 0), "Authentic Channel", fill: colors-l.darkblue),

  keynode((0, 2), label: [E]),
  edge("-|>"),
  node((1, 2), "Authentic Channel", fill: colors-l.darkblue),
  edge("-|>"),
  keynode((2, 2), label: [D]),
  node((1, 2.75), [Symmetric Encryption\ Protocol], stroke: none),
  node((4, 2), $->$, stroke: none),
  node((5, 2), "Secure Channel", fill: colors-l.green),

  keynode((-1, 4), label: [E]),
  edge("-|>"),
  keynode((0, 4), label: [M]),
  edge("-|>"),
  node((1, 4), "Insecure Channel", fill: colors-l.red),
  edge("-|>"),
  keynode((2, 4), label: [V]),
  edge("-|>"),
  keynode((3, 4), label: [D]),
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
  [Signals sent

  ]

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

  [

    Randomization of output when using wrong polarization

  ]

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

  [

    Possible outcomes

  ]

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

==== Eavesdropping

Without Eavesdropping (Theoretical error rate: 0%):
#grid(
  columns: (1fr, 1fr),
  stroke: .5pt,
  gutter: 0pt,
  inset: .5em,
  grid.cell(fill: colors-l.comment)[50% chance Alice and Bob disagree on base],
  grid.cell(fill: colors-l.green)[Bob gets correct bit],
)
With Eavesdropping (Theoretical error rate: 25%):
#grid(
  columns: (1fr, 1fr, 1fr, 1fr),
  rows: (3em, 3em),
  gutter: 0pt,
  inset: .5em,
  stroke: .5pt,
  grid.cell(colspan: 2, rowspan: 2, fill: colors-l.comment)[50% chance Alice and
    Bob disagree on base],
  grid.cell(colspan: 2, fill: colors-l.green)[50% chance attacker guesses right
    base],
  grid.cell(fill: colors-l.green)[Wrong base but Bob gets correct bit],
  grid.cell(fill: colors-l.red)[Wrong base and Bob gets wrong bit],
)

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

Protects the #highlight(fill: colors-l.darkblue)[integrity/authenticity] of the
payload and parts of the IP header (#tp[purple]). Provides (optional) replay
protection, does not provide confidentiality.

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
    node((1, 1), fill: colors-l.purple, width: 8em)[AH],
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

Provides #highlight(fill: colors-l.green)[Confidentiality and authenticity] of
the payload. Authenticity (via ICV) and replay protection is optional (but
recommended).

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
    node((1, 1), fill: colors-l.purple, width: 8em)[ESP-Header],
    node((2, 1), width: 16em)[Payload],
    node((3, 1), fill: colors-l.purple, width: 8em)[ESP-Trailer],
    node((4, 1), fill: colors-l.purple, width: 8em)[ESP-ICV],
  ))
}

#todo[W4 S14]

== Modes of Operation

=== Transport vs. Tunnel Mode

Both AH and ESP have two modes of operation:
/ Transport Mode: Protects IP packets directly
#{
  set text(font: code-font, size: .9em)
  show "Authenticated": highlight.with(fill: colors-l.darkblue)
  show "Encrypted": highlight.with(fill: colors-l.green)
  grid(
    columns: 1,
    diagram(
      spacing: (0pt, 1em),
      edge((0.5, 0), (3, 0), "->", label: "Authenticated"),
      edge((-1, 0), (.5, 0), "<.."),
      node((0, 1), width: 8em)[IP Header],
      node((1, 1), fill: colors-l.purple, width: 8em)[AH],
      node((2, 1), width: 10em)[Payload],
    ),
    diagram(
      spacing: (0pt, 1em),
      edge((0.5, 0), (5, 0), "<->", label: "Authenticated"),
      edge((1.45, 2), (3.5, 2), "<->", label: "Encrypted"),
      node((0, 1), width: 8em)[IP Header],
      node((1, 1), fill: colors-l.purple, width: 8em)[ESP-Header],
      node((2, 1), width: 10em)[Payload],
      node((3, 1), fill: colors-l.purple, width: 8em)[ESP-Trailer],
      node((4, 1), fill: colors-l.purple, width: 8em)[ESP-ICV],
    ),
  )
}
/ Tunnel Mode: IP packets are packed into a new IP packet (as payload) which is
  then protected
#{
  set text(font: code-font, size: .9em)
  show "Authenticated": highlight.with(fill: colors-l.darkblue)
  show "Encrypted": highlight.with(fill: colors-l.green)
  grid(
    columns: 1,
    diagram(
      spacing: (0pt, 1em),
      edge((-.5, 0), (3, 0), "->", label: "Authenticated"),
      edge((-2, 0), (-.5, 0), "<.."),
      node((-1, 1), width: 8em)[new IP H.],
      node((0, 1), fill: colors-l.purple, width: 8em)[AH],
      node((1, 1), width: 8em)[IP Header],
      node((2, 1), width: 10em)[Payload],
    ),
    diagram(
      spacing: (0pt, 1em),
      edge((-0.5, 0), (5, 0), "<->", label: "Authenticated"),
      edge((0.5, 2), (3.5, 2), "<->", label: "Encrypted"),
      node((-1, 1), width: 8em)[new IP H.],
      node((0, 1), fill: colors-l.purple, width: 8em)[ESP-Header],
      node((1, 1), width: 8em)[IP Header],
      node((2, 1), width: 10em)[Payload],
      node((3, 1), fill: colors-l.purple, width: 8em)[ESP-Trailer],
      node((4, 1), fill: colors-l.purple, width: 8em)[ESP-ICV],
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

This information is stored in a security association (SA), Identified by a
Security Parameters Index (SPI). Separate SAs for each communication direction,
i.e. one per sender, and separate SAs for AH and ESP.

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

== Internet Key Exchange v2 (IKEv2)

Protocol for mutual authentication and building of security associations between
an Initiator and a Responder. #rfc(7296)

Goal: Initiator and Responder each have
- a security association for IKE transport (IKE-SA)
- security associations for ESP or AH traffic (CHILD-SA)

IKE messages are transmitted over UDP (port 500).

Protocol Phases:
#align(center, diagram(
  node-shape: fletcher.shapes.chevron,
  node((0, 0), [INIT], fill: colors-l.darkblue),
  node((1, 0), [AUTH], fill: colors-l.purple),
  node(enclose: ((0, 0), (1, 0)), shape: fletcher.shapes.brace.with(
    dir: bottom,
    label: [Initial Exchanges],
  )),
  node((2, 0), [Child SA Exchange], fill: colors-l.green),
  node((3, 0), [Child SA Exchange], fill: colors-l.green),
  node((4, 0), [...], stroke: none),
))

=== Initial Exchanges

- The first two messages (IKE_SA_INIT) negotiate the security parameters and do
  a DH key exchange.
- The second pair of messages (IKE_AUTH) verifies the identities and establishes
  a first CHILD_SA.

#let gridlp(..args) = {
  pad(left: 2em, top: .5em, grid(..args, columns: (4em, 16em), gutter: .5em))
}

#align(center, seqdiag({
  _par("Initiator")
  _par("Responder")

  _seq("Initiator", "Responder", comment: [#h(2em) IKE_SA_INIT #h(2em)])
  _note("right", gridlp(
    columns: 2,
    [HDR],
    [IKE Header, incl. SPI of I],
    [SAi1],
    [Crypto algorithms supported by I],
    [KEi],
    [I's Diffie-Hellman value],
    [Ni],
    [I's Nonce],
  ))
  _seq("Responder", "Initiator", comment: "IKE_SA_INIT")
  _note("right", gridlp(
    columns: 2,
    [HDR],
    [IKE Header, incl. SPI of R],
    [SAr1],
    [Chosen crypto algo (from SAi1)],
    [KEr],
    [R's Diffie-Hellman value],
    [Nr],
    [R's Nonce],
  ))
  _grp("Encrypted & Authenticated", {
    _seq("Initiator", "Responder", comment: "IKE_AUTH")
    _note("right", gridlp(
      columns: 2,
      [HDR],
      [IKE Header, incl. SPI of I],
      [IDi],
      [Identity of I],
      [[CERT],],
      [[CERT-Request]],
      [AUTH],
      [Signature or MAC],
      [SAi2],
      [Sup. Crypto Algos for IPsec by I],
      [TSi, TSr],
      [Traffic selectors],
    ))
    _seq("Responder", "Initiator", comment: "IKE_AUTH")
    _note("right", gridlp(
      columns: 2,
      [HDR],
      [IKE Header, incl. SPI of R],
      [IDr],
      [Identity of R],
      [[CERT]],
      [],
      [AUTH],
      [Signature or MAC],
      [SAr2],
      [Sup. Crypto Algos for IPsec by R],
      [TSi, TSr],
      [Traffic selectors],
    ))
  })
}))

// #todo[W4 S30,31]

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

Happens on new Child-SA or Rekeying of a Child-SA or Rekeying of the IKE-SA.
Based on existing key material, optionally rekeying using DH.

#align(center, seqdiag({
  _par("Initiator")
  _par("Responder")

  _grp("Encrypted & Authenticated", {
    _seq("Initiator", "Responder", comment: [#h(1em) CREATE_CHILD_SA #h(1em)])
    _note("right", gridlp(
      columns: 2,
      [HDR],
      [Header],
      [SA],
      [SA offer],
      [Ni],
      [Nonce],
      [KEi],
      [Diffie-Hellman share],
      [TSi,TSr],
      [Traffic Selectors],
    ))
    _seq("Responder", "Initiator", comment: "CREATE_CHILD_SA")
    _note("right", gridlp(
      columns: 2,
      [HDR],
      [Header],
      [SA],
      [Accepted SA],
      [Nr],
      [Nonce],
      [KEr],
      [Diffie-Hellman share],
      [TSi,TSr],
      [Traffic Selectors],
    ))
  })
}))

=== INFORMATIONAL

For Control messages, e.g. error messages, event notification, deletion of SAs.

#align(center, seqdiag({
  _par("Initiator")
  _par("Responder")

  _grp("Encrypted & Authenticated", {
    _seq("Initiator", "Responder", comment: [#h(1em) INFORMATIONAL #h(1em)])
    _seq("Responder", "Initiator", comment: "INFORMATIONAL")
  })
}))

=== Key Derivation (Function)

/ PRF: Pseudo Random Function
/ KDF: Key Derivation Function

IKEv2 uses a PRF to derive key material, the PRF depends on cipher suite, e.g.
AES-CMAC. Inputs to the PRF comes from Existing key material, the Nonce, and DH
key exchange (ephemeral key).

#diagram(
  node((.5, -2), [IKE-SA], stroke: none),
  node(enclose: ((-2, -1), (1.5, 2))),
  node((3, -2), [CHILD-SA], stroke: none),
  node(enclose: ((3, -1), (3, 2))),
  node((4, -2), [Re-Keying IKE-SA], stroke: none),
  node(enclose: ((4, -1), (4, 2))),
  node((1, -1), stroke: none, $N_i | N_r | "SPI"_i | "SPI"_r$),
  edge((1, 1), "->"),
  node((-1, 0), stroke: none, $N_i | N_r$),
  edge((0, 0), "->"),
  node((0, -1), stroke: none, $g^(i r)$),
  edge("->"),
  node((0, 0), shape: fletcher.shapes.trapezium.with(dir: bottom), [PRF]),
  edge("->", label: "SKEYSEED", corner: left, label-pos: .3),
  node((1, 1), shape: fletcher.shapes.trapezium.with(dir: bottom), [PRF+]),
  edge((1, 2), "->"),
  node((-.5, 2), stroke: none, $ underbrace("SK"_d, "") $),
  node(
    (0.1, 2),
    stroke: none,
    $
      underbrace(
        "SK"_(a i) space "SK"_(a
        r), "authenticity"
      )
    $,
  ),
  node(
    (.75, 2),
    stroke: none,
    $
      underbrace(
        "SK"_(e i) space "SK"_(e
        r), "encryption"
      )
    $,
  ),
  node(
    (1.5, 2),
    stroke: none,
    $
      underbrace(
        "SK"_(p i) space "SK"_(p
        r), "for AUTH"
      )
    $,
  ),
  node((3, -1), stroke: none, $g^(i r) | N_i | N_r$),
  edge("->"),
  node((3, 0), shape: fletcher.shapes.trapezium.with(dir: bottom), [PRF+]),
  edge("->"),
  node((3, 1), stroke: none, [KEYMAT]),
  node((4, -1), stroke: none, $g^(i r) | N_i | N_r$),
  edge("->"),
  node((4, 0), shape: fletcher.shapes.trapezium.with(dir: bottom), [PRF+]),
  edge("->"),
  node((4, 1), stroke: none, [SKEYSEED]),
  edge((-.5, 2), (-.5, 2.5), (2.5, 2.5), (2.5, 0), (3, 0), "->"),
  edge((-.5, 2), (-.5, 2.5), (3.65, 2.5), (3.65, 0), (4, 0), "->"),
)

#todo[W4 S36]

=== Algorithms

IPsec use various cryptographic algorithms (in IKEv2 negotiated (SAs)). #rfc(8247) specifies "mandatory-to-implement" algorithms for IKEv2. #rfc(8221) specifies
algorithms for AH. Various RFCS define cipher suites with the goal of
interoperability and a certain level of security, like #rfc(4308): Cryptographic
Suites for IPsec (2005).

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
- One-to-One NAT: TCP (and UDP in IPv6) has checksums that break when swapping
  out IP

In IKE:
- Using IP addresses as an identifier (IKEv1) causes issues.
- IKE responder needs to accept packets from a non 500 port.

=== NAT-T and IPsec

#rfc(3948): UDP-Encapsulation of IPsec ESP Packets
- UDP-Header between IP-Header and ESP-Header
- Source und destination port: 4500

#align(center, diagram(
  spacing: 0pt,
  node((0, 0), [IP Hdr]),
  node((1, 0), fill: colors-l.comment, [UDP Hdr]),
  node((2, 0), fill: colors-l.purple, [ESP Hdr]),
  node((3, 0), [Payload]),
  node((4, 0), fill: colors-l.purple, [ESP Trailer]),
  node((5, 0), fill: colors-l.purple, [ICV]),
))

#rfc(4306): IKEv2 can (implementation optional)
- Detect NAT (NAT_DETECTION_SOURCE_IP and NAT_DETECTION_DESTINATION_IP in
  INIT-msg)
- Negotiate UDP-Encapsulation for IKE and ESP
- Source und dst. port: 4500, reply to arbitrary port

#align(center, diagram(
  spacing: 0pt,
  node((0, 0), [IP Hdr]),
  node((1, 0), fill: colors-l.comment, [UDP Hdr]),
  node((2, 0), fill: colors-l.purple, [Non-ESP Marker]),
  node((3, 0), fill: colors-l.purple, [IKE]),
))

= WireGuard

Wireguard is a Fast, Modern, Secure, Free, Open Source, Best, Bestest VPN
Tunnel.

== Crypto stack

Symmetric:
- ChaCha20 for symmetric encryption, authenticated with Poly1305, using #rfc(7539)'s AEAD construction
- BLAKE2s for hashing and keyed hashing, described in #rfc(7693)
- SipHash24 for hashtable keys
- HKDF for key derivation, as described in #rfc(5869)
Asymmetric:
- Curve25519 for ECDH, the public and private keys are for DH

== Setup

- Both parties generate a DH key pair.
- Exchange public keys with each other (done by an admin not the WireGuard
  protocol).
- Each party has a config file that maps the other party's public key to their
  AllowedIPs
- When connecting a handshake of two messages is exchanged to verify the
  identity of the other party

== Protocol Phases

#align(center, diagram(
  node-shape: fletcher.shapes.chevron,
  node((0, 0), [Handshake], fill: colors-l.darkblue),
  node((1, 0), [Data Packet Exchange], fill: colors-l.green),
  node((2, 0), [...], stroke: none),
  node((3, 0), [Rekeying], fill: colors-l.purple),
  node((4, 0), [Data Packet Exchange], fill: colors-l.green),
  node((5, 0), [...], stroke: none),
))

=== Connection establishment

WireGuard uses the #link("https://noiseexplorer.com/patterns/IK/", "Noise_IK")
handshake pattern of the Noise Protocol Framework
/ I (Immediate): The initiator's own static public key is transmitted
  (encrypted) inside Message 1, so the responder learns the initiator's identity
  during the handshake itself.
/ K (Known): The initiator already knows the responder's static public key
  before the handshake begins, because both sides configured each other's public
  keys out-of-band as part of setup.

=== First Handshake Message

Initiator sends a message to the responder with:
/ Ephemeral (public key): Initiator's one-time key for this session, in
  plaintext.
/ Encrypted Static (public key): Initiator’s long-term static public key,
  encrypted under a combination of the initiator’s ephemeral key and the
  responder’s pre-known static public key.
/ Encrypted Timestamp (TAI64N): 12 Byte, for replay protection

=== Second Handshake Message

Responder sends a message to the responder, after processing the first message,
with:
/ Ephemeral (public key): Responder's one-time key for this session, in
  plaintext.
/ Encrypted Empty (payload): Proof of key possession $->$ Encrypting an empty
  payload forces the responder to demonstrate it has correctly derived the same
  session key material as the initiator, without transmitting any additional
  identifying information.

=== Key Derivation

Conceptually a combination of DH and KDF as in IKE, but the overall design
simpler than IKE.
- Long-term keys are used for authentication
- Ephemeral keys provide forward secrecy

/ Encryption: One key for each direction of communication
/ Post-quantum: Add pre-shared key into the mix

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
  [Frequent Mobile Roaming, Enterprise and Legacy Hardware, Regulatory
    Compliance],

  [High-Performance Streaming and Gaming, Simple DIY and Self-Hosted VPNs,
    Resource-Constrained Hardware],
)

= DNSSEC

== Dan Kaminsky DNS Vulnerability (cache poisoning)

+ Bad guy sends a DNS query to the victim nameserver for the hostname it wishes
  to hijack
+ Knowing that the victim will shortly be asking ns1.bankofsteve.com (as
  directed from the root/GTLD servers) for an IP address, the bad guy starts
  flooding the victim with forged DNS reply packets. All purport to be from
  ns1.bankofsteve.com, but include the answer with the IP of badguy's fraudulent
  webserver
+ Root/GTLD servers provide referral to ns1.bankofsteve.com
+ Victim nameserver asks ns1.bankofsteve.com for the IP address of
  www.bankofsteve.com, and it uses query ID 1001 (one higher than the previous
  query)
+ The real nameserver provides a legitimate response to this query, with
  QID=1001. But if the bad guy has successfully matched the query ID in the step
  2) flood, this legal reply arrives too late and is ignored
+ With the bogus IP address (of the bad guy's webserver) in cache it provides
  this poisoned answer to the requesting DNS client
+ Future DNS clients asking for www.bankofsteve.com will receive the same
  fraudulent answer

== DNS Security Extensions (DNSSEC)

#rfc(4033), #rfc(4034), #rfc(4035)

Provides *end-to-end protection through the use of digital signatures* that are
created by responding zone administrators and verified by a recipient's resolver
software.

*Avoids the need to trust intermediate name servers and resolvers* that cache or
route the DNS records originating from the responding zone administrator before
they reach the source of the query.

Consists of a set of *new resource record types and modifications to the
existing DNS protocol*.

=== RRsets

Group all the records with the same *type* and the same *name* into a _resource
record set_ (#highlight(fill: colors-l.comment)[RRset]). The full RRset gets
digitally signed and not the individual DNS records .

#{
  let node = node.with(fill: colors.bg)
  align(center, diagram(
    node((0, 0), [AAAA]),
    node((1, 0), [AAAA]),
    node((2, 0), [AAAA]),
    node(enclose: ((0, 0), (2, 0)), fill: colors-l.comment),
    node(enclose: ((0, 0), (2, 0)), shape: fletcher.shapes.brace.with(
      sep: 2pt,
      label: [RRset],
    )),

    node((4, 0), [MX]),
    node((5, 0), [MX]),
    node((6, 0), [MX]),
    node((7, 0), [MX]),
    node(enclose: ((4, 0), (7, 0)), fill: colors-l.comment),
    node(enclose: ((4, 0), (7, 0)), shape: fletcher.shapes.brace.with(
      sep: 2pt,
      label: [RRset],
    )),
  ))
}

=== Zone Signing Keys (ZSK)

Each zone in DNSSEC has a zone-signing key pair (#highlight(fill: colors-l.darkblue)[ZSK])
- The private key digitally signs each RRset in the zone
- The public key portion verifies the signature

A zone operator creates digital signatures (RRSIG) for each RRset using the
private ZSK. The RRSIG is stored in the name server as a RRSIG record.

The zone operator also needs to make their public ZSK available by adding it to
the name server in a DNSKEY record.

=== Validation

When a DNSSEC resolver requests a particular record type (e.g., AAAA), the name
server also returns the corresponding RRSIG and DNSKEY records. The resolver can
validate the response with the RRset, RRSIG, and public ZSK.

=== Key Signing Keys (KSK)

In addition to a zone-signing key, DNSSEC name servers also have a key-signing
key (#highlight(fill: colors-l.purple)[KSK]). The KSK validates the DNSKEY
records in exactly the same way as our ZSK secured our RRsets. The name server
publishes the public KSK in another DNSKEY record.

#todo[for rotating keys]

=== Overview

#{
  let node = node.with(width: 8em, height: 3em)
  show raw: box.with(fill: colors.comment, outset: .25em)
  align(center, diagram(
    spacing: (4em, 1em),
    node((0, 1), [`RRset`\ DNSKEY], fill: colors-l.comment),
    edge((1, 2), "-|>"),
    node((0, 2), [`RRSIG`\ RRSIG], fill: colors-l.purple),
    edge((1, 2), "-|>"),
    node((0, 3), [`DNSKEY`\ Public KSK], fill: colors-l.purple),
    edge((1, 2), "-|>"),

    node((1, 0), [`RRset`\ AAAA], fill: colors-l.comment),
    edge((2, 1), "-|>"),
    node((1, 1), [`RRSIG`\ RRSIG], fill: colors-l.darkblue),
    edge((2, 1), "-|>"),
    node((1, 2), [`DNSKEY`\ Public ZSK], fill: colors-l.darkblue),
    edge((2, 1), "-|>"),

    node((2, 1), [Verified RRset], fill: colors-l.green),
  ))
}

=== Resource Records

==== DNS Public Key (DNSKEY)

The DNS Public Key used to sign the RRsets of a zone
#{
  show "256": highlight.with(fill: colors-l.darkblue)
  show "257": highlight.with(fill: colors-l.purple)
  show "13": highlight.with(fill: colors-l.green)
  ```
  switch.ch.		23248	IN	DNSKEY	256 3 13
                jVcj6ASFVqqUcjqtEjUG38+WVvbplnyelv9VBrSck5F5jzeionSDfn1F
                vreNQh37pLNpR2wlV+yrsLcpbM7qYQ==
  switch.ch.		23248	IN	DNSKEY	257 3 13
                75SbTSctA8tgapqpGQSk8wpDl/ngvY4av6XJ/79ABB1cd1AxTNZDhl8y
                +8h0j8+TPmfwGD2CLvqnMQCsjyvmwQ==
  ```
}

Flags field
- #highlight(fill: colors-l.darkblue)[256] $->$ Zone Signing Key (ZSK)
- #highlight(fill: colors-l.purple)[257] $->$ Key Signing Key (KSK) with secure
  entry point (SEP) flag set
Algorithm field
- 5 $->$ SHA-1 with RSA
- 8 $->$ SHA-256 with RSA
- 10 $->$ SHA-512 with RSA
- #highlight(fill: colors-l.green)[13] $->$ SHA-256 with ECDSA
- 14 $->$ SHA-384 with ECDSA

==== Resource Record Signature (RRSIG)

Contains a public key signature over a resource record set.

#{
  show "20261107122148": highlight.with(fill: colors-l.green)
  show "20260922112148": highlight.with(fill: colors-l.green)
  show "26104": highlight.with(fill: colors-l.darkblue)
  ```
  switch.ch.		22738	IN	RRSIG	DNSKEY 13 2 86400
                20261107122148 20260922112148 26104 switch.ch.
                UoCt+fO0/Xs8j9SeKOqol1rTociNYnbhJDF1Up2bWLimYNEaV/x682Pt
                Iih9nNxTqXNjnRwY1U6Cv2s+T8NWkQ==
  ```
}

#highlight(fill: colors-l.green)[Signature Expiration and Inception Fields]: The
signature is not valid before Inception and after Expiration date.

#highlight(fill: colors-l.darkblue)[Key Tag Field]: Contains the key tag of the
key which signed the RRset.

==== Delegation Signer Records (DS)

DNSSEC introduces a delegation signer (DS) record to allow the transfer of trust
from a parent zone to a child zone. A zone operator hashes the DNSKEY record
containing the public KSK and gives it to the parent zone to publish as a DS
record.

#{
  show "KSK": highlight.with(fill: colors-l.purple)
  align(center, diagram(
    spacing: (2em, 1em),
    node(enclose: ((0, 0), (0.5, -1), (1, 0)), fill: colors-l.red),
    node((0.5, -1), [Root\ server zone], stroke: none),
    node((0, 0), [`DNSKEY`\ Public KSK]),
    node((1, 0), [`DS`\ Hashed KSK], fill: colors-l.orange),
    edge((3, 0), "-|>"),
    node(enclose: ((3, 0), (3.5, -1), (4, 0)), fill: colors-l.orange),
    node((3.5, -1), [TLD\ server zone], stroke: none),
    node((3, 0), [`DNSKEY`\ Public KSK]),
    node((4, 0), [`DS`\ Hashed KSK], fill: colors-l.yellow),
    edge((6, 0), "-|>"),
    node(enclose: ((6, 0), (6, -1)), fill: colors-l.yellow),
    node((6, -1), [Authoritative\ server zone], stroke: none),
    node((6, 0), [`DNSKEY`\ Public KSK]),
  ))
}

Every time a resolver is referred to a child zone, the parent zone also provides
a DS record. This DS record is how resolvers know that the child zone is
DNSSEC-enabled.

To check the validity of the child zone's public KSK, the resolver hashes it and
compares it to the DS record from the parent. If they match, the resolver can
assume that the public KSK hasn't been tampered with, which means it can trust
all of the records in the child zone.

This is how a chain of trust is established in DNSSEC.

=== Denial of existence

If you ask DNS for the IP address of a domain that doesn't exist, it returns an
empty answer This is a problem if you want to authenticate the response, since
there's no message to sign. DNSSEC fixes this by adding the NSEC and NSEC3
record types.

==== Next Owner Name (NSEC)

#[
  #show "nsec3.switch.ch": highlight.with(fill: colors-l.green)
  #show "25876": highlight.with(fill: colors-l.darkblue)
  #show "ns2.switch.ch": highlight.with(fill: colors-l.darkblue)
  ```
  ns2.switch.ch. 179 IN NSEC  nsec3.switch.ch.
                 A PTR AAAA RRSIG NSEC
  ns2.switch.ch. 179 IN RRSIG NSEC 13 3 180
                 20161112201311 20161021040550 25876 switch.ch.
                 3mDDwKXFtgeJSUBe0WEvtVhwwjO2MPxa
                 2KONRTGz6/24+v0qB0PMrKsaQVtK26Ls
                 1Vmk/hbQCorRcIByLrglzQ==
  ```

  Proof that there is no name between ns2.switch.ch. and nsec3.switch.ch.
]

#tr[Allows enumeration of complete zone data.]

==== Next Owner Name in Hashed Order (NSEC3)

#[
  #show "h9p7u7tr2u91d0v0ljs9l1gidnp90u3h.org": highlight.with(
    fill: colors-l.darkblue,
  )
  #show "h9rsfb7fpf2l8hg35cmpc765tdk23rp6": highlight.with(fill: colors-l.green)
  #show "???.org": highlight.with(fill: colors-l.green)
  ```
  h9p7u7tr2u91d0v0ljs9l1gidnp90u3h.org. 691 IN NSEC3
                 1 1 1 d399eaab
  h9rsfb7fpf2l8hg35cmpc765tdk23rp6
                 NS SOA RRSIG DNSKEY NSEC3PARAM ; flags: optout
  h9p7u7tr2u91d0v0ljs9l1gidnp90u3h.org. 691 IN RRSIG NSEC3 7 2
                 86400 20091202211702 20091118201702 5273 org.
                 a+CC37hRM7yCFBaZn2SeRgY9h247GXptCuBYf45TwaoR
                 xvBwTAXPT+UwZ/4hxwc2v7AR7ZZ8UOMiNJvYsl59eFW8
                 Xtgws4/Aih0fJ2/O8yUHwI695fRf9PrpxXEpqzStjSZP
                 5arJ1oldDAHcnxgLqdAMW6wnK1FNrslfJblJlmU=
  ```
  Proof that there is no name between #highlight(fill: colors-l.darkblue, [org]). and ???.org.
]

#tg[Does not allow straight enumeration of zone data.]

=== DNS-Based Authentication of Named Entities (DANE)

Through DANE the browser can check the TLSA record for a public fingerprint of a
certificate that the user has marked as safe.

DANE, defined in #rfc(6698), is a protocol to allow X.509 certificates, commonly
used for Transport Layer Security (TLS), to be bound to DNS names using DNSSEC,
as a means to authenticate TLS client and server entities without a certificate
authority (CA). The purpose of DANE is to replace reliance on the security of
the CA system with reliance on the security provided by DNSSEC. It defines a new
DNS record type, TLSA, that can be used for a secure method of authenticating
SSL/TLS certificates.

#todo[
  The TLSA RRs used by DANE store hashes of entire certificates or the public
  key (subject- PublicKeyInfo) or their complete encoding. There are four ways
  of establishing trust in the server certificate, which were given new acronyms
  with #rfc(7218):
  - A CA certificate is referenced which must appear in the normally verified
    chain of trust ("CA constraint" or PKIX-TA).
  - Reference the end entity certificate of the server whose chain of trust is
    otherwise normally verified ("service certificate constraint" or PKIX-EE).
  - The trust anchor (CA) is referenced, which does not have to be known to the
    client beforehand - this also works for self-signed CAs ("trust anchor
    assertion" or DANE-TA).
  - You reference the certificate of the server whose trust chain is not
    checked. This works with self-signed certificates ("domain-issued
    certificate" or DANE-EE). The names in the certificate do not even have to
    match the host name.

  Since this in combination with the type of reference (certificate or PK) and
  the data to be transmitted (complete, SHA-256 or SHA-512 hash) results in 24
  possible configurations, only certain combinations were recommended for use by
  #rfc(7671). This should simplify the implementation of clients and deployment
  as well.

  A client locates TLSA RRs by the name `_<port>._<proto>.<domain>`, where
  `<proto>` is the transport protocol (tcp, udp, etc.) and `<port>` represents
  the port used (e.g. 443 for HTTPS).
]

#frame(
  (
    "Cert. Usage": (
      size: 8,
      desc: [
        `0` = CA Certificate Constraint \
        `1` = Server Certificate Constraint \
        `2` = Trust Anchor Assertion for Private CA \
        `3` = Domain Issued Certificate (self-signed)
      ],
    ),
    "Selector": (
      size: 8,
      desc: [
        `0` = Full Certificate \
        `1` = Public Key Info (Public Key plus Key Type Information)
      ],
    ),
    "Matching Type": (
      size: 8,
      desc: [
        `0` = Exact Match on Selected Content \
        `1` = SHA-256 Hash of Selected Content \
        `2` = SHA-512 Hash of Selected Content
      ],
    ),
    "": 8,
  ),
  (
    "Certificate Association Data": 32,
  ),
)

#todo[W5 S42..46]

=== Deployment

DNSSEC's adoption isn't too wide-spread at the moment. :(

=== Root zone signing key

The root DNS zone has no parent, so how can we trust the integrity and
authenticity of its information?

That's the purpose of the Root Signing Ceremony - a rigorous procedure around
signing the root DNS zone's public keying information. The private signing key
used in this process is quite literally the key to the entire DNSSEC-protected
Internet. (I don't see any problem there...)

There are two geographically distinct locations that safeguard the root
key-signing key: El Segundo, CA and Culpeper, VA. Both are secure facilities,
and they contain redundant copies of the key.

= Network Access Control (NAC)

Network Access Control is an umbrella term for managing access to a network:
- Users logging into the network are authenticated and determined what data they
  can access and actions they can perform
- The health of the user's computer or mobile device is checked. E.g. It can
  then be put into the isolation network if the device misses updates and can
  fetch them there

It provides an authentic channel on the data link layer. Auth doesn't happen at
authenticator (enforcement point) but at server.

#{
  let node = node.with(width: 4em, height: 5em)
  align(center, diagram(
    node-stroke: colors.darkblue,
    spacing: (6em, 6em),

    node((0, 0), shape: monitor.with(label: [NAC Client])),
    edge(label: to[block]),
    node(
      (1, 0),
      shape: switch.with(label: align(center)[NAC Policy\ Enforcement Point]),
      name: <nacpep>,
    ),
    edge(<nacsrv>, <nacpep>, label: tg[allow]),
    node((2, 0), shape: server.with(label: "NAC Server"), name: <nacsrv>),
    edge(),
    node((3, 0), shape: server.with(label: "Policy Manager")),
    node((1, 1), shape: server, name: <srv>),
    edge(<srv>, <nacpep>, label: tr[isolate]),

    node(enclose: ((2, 0), (3, 0), (2, .5)), shape: cloud, inset: 4em),
    node((2.5, -0.25), box(width: 8em, tg[Corporate\ Network]), stroke: none),
    node(enclose: ((1, 1), (0, 1.75), (1.5, 1)), shape: cloud),
    node((0.5, 1.25), box(width: 8em, tr[Isolation\ Network]), stroke: none),
  ))
}

There are many network access enforcement methods, the common ones include:
- Layer 2: IEEE 802.1X (switches and WLAN access points)
- Layer 2: Virtual local area networks (VLAN)
- Layer 3: VPN (IKEv2)
- Layer 4: VPN proprietary over TLS
- Firewalls
- DHCP management

== Port-Based Network Access Control - IEEE 802.1X

/ EAP: Extensible Authentication Protocol
/ EAPOL: EAP over LAN
/ #tp[MSK]: EAP Master Session Key
/ PAE: Port Access Entity. 802.1X Supplicants and Authenticators are both PAEs
#{
  let node = node.with(width: 4em, height: 5em)
  align(center, diagram(
    node-stroke: colors.darkblue,
    spacing: (10em, 6em),

    node(
      (-.5, -.5),
      shape: user.with(
        fill: colors.green,
        stroke: colors-l.green,
        label: tg[1. User\ Credentials],
      ),
      height: 3em,
      width: 3em,
    ),
    node(
      (2, -.5),
      shape: user.with(
        fill: colors.green,
        stroke: colors-l.green,
      ),
      height: 3em,
      width: 3em,
    ),

    pkeynode((0, -.5), label: tp[2. MSK]),
    pkeynode((1, -.5)),

    node((0, 0), shape: monitor.with(label: [802.1X Supplicant])),
    edge("<|-|>", label: [EAPOL]),
    node((1, 0), shape: switch.with(label: align(center)[802.1X
      Authenticator])),
    edge("<|-|>", label: [EAP RADIUS]),
    node((2, 0), shape: server.with(label: [802.1X Authentication Server])),
  ))
}
#tp[MSK] is established between supplicant and authenticator after successful
#tg[authentication].

/ Authentication Server: The device that handles authentication, authorization,
  and accounting (AAA) services on a network. User accounts are created and
  stored; privileges and policies are applied.
/ Authenticator: The network device that is attempted to be accessed, e.g.
  wireless router/access point or a network switch. It has no idea of what EAP
  type is in use, or if the user's credentials are valid. It simply takes the
  unmodified EAP frame and encapsulates it within the RADIUS packet sent to the
  authentication server and authorizes the port if the authentication server
  tells it to.
/ Supplicant: The client device, such as a smartphone or laptop computer, that
  wants to access the network.

The actual EAP identity exchange and authentication is occurring between the
supplicant and the authentication server.

=== Authentication

The authentication can be initiated by either authenticator or supplicant:
/ Authenticator: If the link state changes from down to up or periodically as
  long as the port remains up and unauthenticated. The switch sends an
  EAP-request/identity frame to the endpoint to request its identity
/ Supplicant: Triggers the authenticator to request an identity by sending an
  `EAPoL_Start` message at any time.

== Extensible Authentication Protocol (EAP)

#rfc(3748), #rfc(5247)

EAP Provides a protocol to encapsulate different authentication methods.

=== Native mode

#{
  let node = node.with(width: 4em, height: 5em)
  align(center, diagram(
    node-stroke: colors.darkblue,
    spacing: (10em, 1em),

    node(
      enclose: ((1.1, -1), (1.9, -1)),
      fill: colors-l.red,
      stroke: colors.red,
      height: 3em,
    ),
    node(
      enclose: ((0, -1), (2, -1)),
      [EAP Authentication],
      fill: colors-l.green,
      stroke: colors.green,
      height: 2em,
    ),
    node((1.5, -.5), tr[RADIUS], width: 8em, stroke: none),

    node((0, 0), shape: monitor.with(label: [Supplicant])),
    edge("<|-|>"),
    node((1, 0), shape: switch.with(label: align(
      center,
    )[Authenticator])),
    edge("<|-|>"),
    node((2, 0), shape: server.with(label: [Authentication Server])),
  ))
}

/ EAP-MD5: Uses the MD5 message-digest algorithm to hide the credentials in a
  hash. It does not have a mechanism for mutual authentication. That means the
  server validates the client, but the client does not authenticate the server.
/ EAP-TLS: Uses TLS to provide the secure identity transaction through X.509
  certificates, which provide strong authentication. It's an open IETF standard.
  Authentication occurs automatically, with no intervention by user, there's no
  dependency on user password. Autonomous enrollment benefits from this (IoT
  devices can each have their certificate instead of username/password)

=== Tunneled mode

#{
  let node = node.with(width: 4em, height: 5em)
  align(center, diagram(
    node-stroke: colors.darkblue,
    spacing: (10em, 1em),

    node(
      enclose: ((1.1, -1), (1.9, -1)),
      fill: colors-l.red,
      stroke: colors.red,
      height: 4em,
    ),
    node(
      enclose: ((.05, -1), (1.95, -1)),
      [EAP Authentication],
      fill: colors-l.purple,
      stroke: colors.purple,
      height: 3em,
    ),
    node(
      enclose: ((0, -1), (2, -1)),
      [EAP Authentication],
      fill: colors-l.green,
      stroke: colors.green,
      height: 2em,
    ),
    node((1.5, -.5), tr[RADIUS], width: 8em, stroke: none),
    node((.5, -.5), tp[TLS Outer Tunnel], width: 10em, stroke: none),

    node((0, 0), shape: monitor.with(label: [Supplicant])),
    edge("<|-|>"),
    node((1, 0), shape: switch.with(label: align(
      center,
    )[Authenticator])),
    edge("<|-|>"),
    node((2, 0), shape: server.with(label: [Authentication Server])),
  ))
}


Whereas the native EAP types send their credentials immediately, tunneled EAP
types form an encrypted tunnel first and then transmit the credentials with
native EAP within that tunnel.

With tunneled EAP types, there is a concept of inner and outer identities:

/ Inner identity: is the user or device's actual identity credentials sent with
  the native EAP protocol.
/ Outer identity: is typically set to "anonymous". It's the identity that is
  used between the supplicant and the authentication server for the initial TLS
  tunnel setup.

Cisco ISE is able to read that outer identity and use it to help make identity
store selection decisions. Most supplicants (except e.g. Android) will hide this
option from the end user, and only administrators see the outer identity.

==== Protected EAP (PEAP)

Forms an encrypted TLS tunnel between the client and server, using the X.509
certificate on the server. After the tunnel has been formed, PEAP uses one of
the following EAP types as an inner method for authenticating the client using
EAP within the outer tunnel.
/ MSCHAPv2: is the most common inner method, as it allows for simple
  transmission of username and password, or even computer name and computer
  password, to the RADIUS server. (Microslop Challenge Handshake Authentication
  Protocol Version 2)
/ PEAP: is capable of using EAP-TLS as an inner method but it is rarely used.

==== Flexible Authentication via Secure Tunneling (EAP-FAST)

Created by Cisco Systems as an alternative to PEAP to allow for faster
re-authentications and support faster wireless roaming. FAST forms a TLS outer
tunnel and then transmits the client credentials within this TLS tunnel. It has
the ability to use Protected Access Credentials (PACs). A PAC can be thought of
like a secure "cookie", stored locally on the host as "proof" of a successful
authentication.
/ EAP-MSCHAPv2: is the most common inner method.
/ EAP-TLS: EAP-FAST is capable of using it as an inner method. This has become
  quite popular with EAP-Chaining (Authenticating Computer and User).




#{
  [Step 1: Key established between supplicant and Authentication Server]
  let node = node.with(width: 4em, height: 5em)
  align(center, diagram(
    node-stroke: colors.darkblue,
    spacing: (10em, 1em),

    node(
      enclose: ((1.1, -1), (1.9, -1)),
      fill: colors-l.red,
      stroke: colors.red,
      height: 4em,
    ),
    node(
      enclose: ((.05, -1), (1.95, -1)),
      [EAP Authentication],
      fill: colors-l.purple,
      stroke: colors.purple,
      height: 3em,
    ),
    node(
      enclose: ((0, -1), (2, -1)),
      [EAP Authentication],
      fill: colors-l.green,
      stroke: colors.green,
      height: 2em,
    ),
    pkeynode((-.25, -1)),
    pkeynode((2.25, -1)),
    node((1.5, -.5), tr[RADIUS], width: 8em, stroke: none),
    node((.5, -.5), tp[TLS Outer Tunnel], width: 10em, stroke: none),

    node((0, 0), shape: monitor.with(label: [Supplicant])),
    edge("<|-|>"),
    node((1, 0), shape: switch.with(label: align(
      center,
    )[Authenticator])),
    edge("<|-|>"),
    node((2, 0), shape: server.with(label: [Authentication Server])),
  ))

  [
    But with TLS the authenticator can't see the key, so:

    Step 2: Authentication Server sends key to Authenticator
  ]

  align(center, diagram(
    node-stroke: colors.darkblue,
    spacing: (10em, 1em),

    pkeynode((0, -1)),
    pkeynode((2, -1)),
    edge("-|>"),
    pkeynode((1, -1)),

    node((0, 0), shape: monitor.with(label: [Supplicant])),
    edge("<|-|>"),
    node((1, 0), shape: switch.with(label: align(
      center,
    )[Authenticator])),
    edge("<|-|>"),
    node((2, 0), shape: server.with(label: [Authentication Server])),
  ))
}

== Secure Device Identity (DevID) - IEEE 802.1AR-2018

/ DevID: Secure Device Identifier
/ IDevID: Initial Device Identifier \
  Created during manufacturing and cannot be modified Either reaches end of
  lifetime (certificate) or can be disabled
/ LDevID: Local Device Identifier \
  One or several may be created by network administrator
/ DevID Module: Hardware module which stores the DevID secrets, credentials and
  the entire credential chain up to the root certificate. It contains a strong
  RNG and Implements Asymmetric Algorithms (2048 bit RSA and/or 256 bit ECDSA)
  as well as a SHA-256 Hash Function.

A DevID is cryptographically bound to a device and supports authentication of
the device's identity. An IDevID provided by the supplier of a device can be
supplemented by LDevIDs facilitating enrollment (provisioning of authentication
and authorization credentials) by local network administrators.

=== Use of DevIDs

/ EAP-TLS Authentication: Device authentication can be based on its DevID
  certificate.
/ Consumer Devices: Similar but more secure than access control based on a MAC
  address list which can easily be spoofed. A switch, router or access point can
  allow access based on a registered commonName (CN), serialNumber (SN) or a
  subjectAltName contained in the DevID certificate.
/ Enterprise Devices:
  Similar to the consumer device use case but the DevID is usually registered
  with a central AAA server (white-listing).
/ DevID Module based on Trusted Platform Module (TPM):
  Each TPM has a unique non-erasable Endorsement Key (EK) to which DevID secrets
  and credentials can be bound.

== Media Acccess Layer Security (MACsec) - IEEE 802.1AE

A network security standard that operates at the medium access control layer and
defines connectionless data confidentiality and integrity for media access
independent protocols.

#{
  show "SecY": text.with(fill: colors.black)
  let node = node.with(width: 4em, height: 5em)
  align(center, diagram(
    spacing: (2em, 2em),
    node(
      enclose: ((0, 0), (0, 1.5), (2, 0)),
      shape: fletcher.shapes.ellipse,
      stroke: colors.green + 2pt,
    ),
    gkeynode((-1, 0), label: tg[CAK]),
    gkeynode((-1, 1.5), label: tg[CAK]),
    gkeynode((3, 0), label: tg[CAK]),
    node((.7, -.7), text(size: 1.5em, tg[CA#sub[ABC]]), stroke: none),
    node((0, 0), shape: monitor.with(label: align(center)[A\ SecY])),
    node((2, 0), shape: monitor.with(label: align(center)[B\ SecY])),
    node((0, 1.5), shape: monitor.with(label: align(center)[C\ SecY])),
    node((2, 2.5), shape: monitor.with(label: align(center)[D])),

    edge((0, 0), (1, .5), "-|>", label: [SC#sub[A]]),
    edge((2, 0), (1, .5), "<|-"),
    edge((0, 1.5), (1, .45), "<|-"),

    edge(shift: (.1, 0), (0, 0), (1, .4), "<|-", stroke: colors.darkblue),
    edge(
      shift: (-.1, 0),
      (2, 0),
      (1, .4),
      "-|>",
      label: td[SC#sub[B]],
      label-side: right,
      label-sep: -2pt,
      stroke: colors.darkblue,
    ),
    edge(shift: (.1, 0), (0, 1.5), (1, .35), "<|-", stroke: colors.darkblue),

    edge(shift: (-.1, 0), (0, 0), (1, .6), "<|-", stroke: colors.purple),
    edge(shift: (.1, 0), (2, 0), (1, .6), "<|-", stroke: colors.purple),
    edge(
      shift: (-.1, 0),
      (0, 1.5),
      (1, .55),
      "-|>",
      label: tp[SC#sub[C]],
      label-side: right,
      label-sep: -4pt,
      stroke: colors.purple,
    ),
  ))
}

D should not get any messages

/ CA: Connectivity Association, the "in group" which should be able to read the
  messages
/ SecY: MAC Security Entity
/ CAK: CA Key, shared between the MAC Security Entities in a CA
/ SC: Secure Channel, from one party to all the others. 3 entities = 3 channels.
/ SA: Secure Association, like in IPSec IKE

Each SC comprises a succession of SAs each with a different SAK (SA Key) (for
rekeying).

#todo[
  two-station: eg client and switch, secure association

  frame format: everything is encrypted
]

=== SC and SA Identifiers

#{
  set text(font: code-font, size: .9em)
  align(center, diagram(
    spacing: (0pt, 1em),
    edge((-1, 2), (3, 2), "<->", label: "SCI"),
    edge((-1, 4), (1.8, 4), "<->", label: "SAI"),
    node((0, 1), height: 3em, width: 40em)[System Identifier],
    node((1, 1), height: 3em, width: 8em)[Port\ Identifier],
    node((2, 1), height: 3em, width: 2em),
    edge("<|-"),
    node((1.2, 0), width: 2em, stroke: none, box(
      width: 20em,
      [Association Number],
    )),
  ))
}

/ SCI: Secure Channel Identifier
/ SAI: Secure Association Identifier
/ System Identifier: MAC address of sender
/ Port Identifier: Allows for multiple channels

The Association Number (2 bits) allows the overlapping rekeying of the Secure
Association during which two different SAKs co-exist.

=== Frame Format

#{
  set text(font: code-font, size: .9em)
  align(center, diagram(
    spacing: (0pt, 1em),
    edge((-1, 3), (1.2, 3), "<->", label: [MAC\ Addr]),
    edge((1.2, 3), (4.8, 3), "<->", label: "MPDU"),
    edge((-1, -2), (4.8, -2), "<->", label: [Authenticity]),
    edge((2.35, 0), (3.65, 0), "<->", label: [Encryption]),
    node((0, 1), height: 3em, width: .9 * 3em)[DA],
    node((1, 1), height: 3em, width: .9 * 3em)[SA],
    node((2, 1), height: 3em, width: .9 * 12em)[SecTag],
    node((3, 1), height: 3em, width: .9 * 24em)[Secure Data],
    node((4, 1), height: 3em, width: .9 * 12em)[ICV],
    node((5, 1), height: 3em, width: .9 * 3em)[FCS],
  ))
}
/ MSDU: MAC Service Data Unit
/ MPDU: MACsec Protocol Data Unit
/ ICV: Integrity Check Value

==== Security Tag (SecTag)

#frame(
  unit: "bytes",
  (
    "0x88E5": (size: 2, desc: [MACsec Ethertype is 0x88E5]),
    "TCI": (size: .5, desc: [TAG Control information]),
    "AN": (size: .5, desc: [Association Number (2bits)]),
    "SL": (
      size: 1,
      desc: [Short Length (6bits) - length of user data if < 48 octets, 0
        otherwise],
    ),
    "PN": (
      size: 4,
      desc: [Packet Number - replay protection and IV for encryption],
    ),
    "SCI": (
      size: 8,
      desc: [Secure Channel Identifier (0 or 8 bytes) - identifies the secure
        channel.],
    ),
  ),
)

In point-to-point links the SCI consists of the Source MAC Address and the fixed
Port Identifier 00-01. Thus, no need to encode the SCI.

==== Tag Control Information Bits (TCI)

#frame((
  V: (size: 1, desc: [version, currently 0]),
  ES: (
    size: 1,
    desc: [If set (=1) means that the Source MAC Address is part of the SCI and
      the SCI does not need to be explicitly encoded],
  ),
  SC: (
    size: 1,
    desc: [If set an explicitly coded SCI is present in the SecTag],
  ),
  SCB: (
    size: 1,
    desc: [Single Copy Broadcast capability, if ES and SCB are set, then the
      implict SCI has a reserved Port Identifier of 00-00.],
  ),
  E: (size: 1, desc: [Encryption, if set means encryption enabled]),
  C: (
    size: 1,
    desc: [Changed Text, if not set means the Secure Data is equal to User
      Data],
  ),
  AN: (size: 2),
))

=== MACsec Key Agreement (MKA) - IEEE 802.1X

#[
  #show "MSK": tp
  #show "CAK": tg
  #show "CKN": text.with(fill: colors-l.green)
  #show "SAK": tr
  #show "ICK": to
  #show "KEK": [#text(fill: colors.green.darken(40%))[KEK] #icon-img(
      "./img/kek.png",
    )]
  #grid(
    columns: 2,
    [
      KDF allow to generate keys for a context given a master key. It's
      deterministic and normally a PRF (HMAC or CMAC).

      The MKA KDF is a PRF based on AES-CMAC with a 128 or 256 bit key. \
      Output $<-$ KDF(Key, Label, Context, Length)

      #align(center, diagram(
        spacing: (8em, 0pt),
        pkeynode((0, 0), label: [MSK]),
        edge("-|>"),
        gkeynode((1, 0), label: [CAK]),
        edge("-|>"),
        rkeynode((2, 0), label: [SAK]),
      ))
    ],
    diagram(
      pkeynode((0, 0)),
      edge((.5, 1), "-|>"),
      node((1, 0), td[*Context*], stroke: none),
      edge("-|>"),
      node((.5, 1), shape: fletcher.shapes.trapezium.with(dir: bottom), [KDF]),
      edge("-|>"),
      gkeynode((.5, 2)),
    ),
  )


  ==== Connectivity Association Key (CAK)

  / CKN: (public) CA Key Name
  / CAK as a Pre-Shared-Key (PSK): Can be used either as a pairwise CAK or group
    CAK and is statically configured (admin must do it manually). CKN can be
    chosen arbitrarily with a size of 1..32 octets.
  / CAK via EAP: Can be used as a pairwise CAK. Dynamically derived CAK and CKN
    between two PAEs via EAP.
    $
      "CAK" <- & "KDF"("MSK"[0..15]\/"MSK"[0..31], "\"IEEE8021 EAP CAK\"", && td("mac1")|td("mac2"), 128\/256) \
      "CKN" <- & "KDF"("MSK"[0..15]\/"MSK"[0..31], "\"IEEE8021 EAP CKN\"",
      "Session-ID", && td("mac1")|td("mac2"), 128\/256)
    $
    where #tg[mac1, mac2] are the MAC addresses of the PAEs and the Master
    Session Key (#td[MSK]) and Session-ID of the EAP method (EAP-TLS, EAP-PEAP,
    etc) is included.

  ==== Secure Association Key (SAK)

  + Members of CA have shared CAK
  + Key Server (KS) generates SAK From CAK via KDF or using fresh randomness
  + KS distributes SAK to other members of CA using MKPDU over EAPOL. MKPDU is
    an "ad-hoc" secure channel which requires keys for integrity (ICK) and
    encryption (KEK) which are generated from CAK via KDF.

  KS can be e.g. the EAP Authenticator.

  ==== MKA random SAK distribution using CAK

  #{
    let edge = edge.with(label-size: .75em, label-fill: colors-l.comment)
    let dedge = edge.with(
      stroke: colors.darkblue,
      label-fill: colors-l.darkblue,
    )
    let gedge = edge.with(stroke: colors.green, label-fill: colors-l.green)
    align(center, diagram(
      spacing: (4em, 3em),
      node-stroke: none,
      node((-.5, 0), [Key Derivation], fill: colors-l.darkblue),
      node((-.5, 2), [Auth. Enc.], fill: colors-l.green),
      dedge((5, 0), (3, 0), "->", label: [Key Server RNG]),
      node((3, 0), [OR]),
      dedge((3, 2), "->"),
      node((1, 0), [CAK]),
      dedge("->", label: "CMAC"),
      dedge((3, 0), "->", label: [CMAC\ \+ Key Server RNG\ \+ Public MKA Data]),
      dedge((2, 1), "->", label: "CMAC"),
      node((0, 1), [ICK]),
      gedge((1, 2), "->", label: [MKA Integrity]),
      node((2, 1), [KEK]),
      gedge("->", label: [Key Wrap]),
      node((1, 2), [+]),
      edge((2, 3), "->", label: [MKPDU]),
      node((3, 2), [SAK]),
      gedge((1, 2), "->"),
      edge("..>"),
      node((2, 3), [distributed SAK]),
    ))
  }

  / CMAC: Is just a specific KDF in this case
  / Integrity key: MAC key
  / Wrapping key: encrypting it
  / MKPDU: MACsec Key Agreement Protocol Data Unit - carried via EAPOL
  / CAK: Connectivity Association Key - pairwise or group root key
  / ICK: ICV Key - used for MKPDU Data Integrity
  / KEK: Key Encrypting Key - used for AES Key Wrap in MKPDU
  / SAK: Secure Association Key

  ==== MKA Key Derivation Function for CAK

  / KS: Key Server - either elected or EAP Authenticator
  / MI: Member Identifier - all members of a CA
  / KN: Key Number - assigned by Key Server
  $
    "KEK" <- & "KDF"("CAK", "\"IEEE8021 KEK\"", "CKN"[0..15], 128\/256) \
    "ICK" <- & "KDF"("CAK", "\"IEEE8021 ICK\"", "CKN"[0..15], 128\/256) \
    "SAK" <- & "KDF"("CAK", "\"IEEE8021 SAK\"", "KS-nonce" | "MI-value list" | "KN" 128\/256) \
  $

  #todo[W6 S47]

  == Trusted Network Connect

  Host is given access to sanitized network only after successful Network
  Endpoint Assessment (NEA) Using Trusted Network Connect (TNC).

  The Platform Trust Service (PTS), comprised of a TSS and TPM, verifies that
  the device is not "lying". The root of trust is usually given by the TPM.

  Integrity Measurement Verifiers (IMVs) are the pieces that gather information
  (e.g. open ports).

  #todo[
    W6 S56..

    diagram:
    - TNC TPM?
  ]
]

= Firewalls

#todo[get updated slides]

A Network Firewall is a host that mediates access to a network. So, it allows,
disallows accesses based on configuration and type of access. A Network
Firewall's characteristics are:
+ All traffic from inside to outside, and vice versa, must pass through the
  firewall
+ Only authorized traffic, as defined by the local security policy, is allowed
  to pass
+ The firewall itself is immune to penetration #comment[\*rawr\*]
Techniques used to control authorized access:
+ Service control (original use): e.g. https
+ Direction control: e.g. ftps inbound only
+ User control: e.g. rdp only in the corporate network for authenticated
  internal users
+ Behaviour control: e.g. SPAM filtered out of email protocols

/ Bastion host: Critical hardened server in the network that serves as a platform for application level or circuit level gateways.
/ Single Bastion Inline: Single firewall device between internal and external router, typically with stateful filters or application proxies implemented (typical setup for S(M)Es).
/ Single Bastion T: Has an additional network interface where externally visible servers are placed (DMZ).
/ Double Bastion Inline: A setup with the DMZ sandwiched between bastion firewalls (typical Setup for medium and large enterprises).
/ Firewall-on-a-Stick: Inspects network traffic only non-blocking.
/ Personal Firewall / Host-Resident Firewall: The firewall functionality is deployed on the server itself.
#todo[W7.1 S35]

== Types

There are different firewall types:

#table(
  columns: (auto, 1fr),
  [Layer], [Type],
  table.cell(rowspan: 2)[_Application_],
  [
    Application Level Firewall ("deep packet inspection")
  ],
  [
    Application Gateways / Proxies ("termination of connection & inspection")
  ],
  [_Transport_],
  [
    Packet Filtering Firewall ("check header")
  ],
  table.cell(rowspan: 2)[_Network_],
  [
    "Primitive Packet" Filter
  ],
  [
    "Secure" Router / Screening Router
  ],
)

All of these types of firewalls can also provide stateful inspection, e.g.
analyzing th order of tcp packets.

#todo[W7 S13,15]

=== Packet Filtering Firewalls

#table(
  columns: 3,
  [Name], [Description], [Countermeasure],
  emph[IP address\ spoofing],
  [The intruder transmits packets from the outside with a source IP address
    field containing an address of an internal host],
  [Discard packets with an inside source address if the packet arrives on an
    external interface],

  emph[Source\ routing\ attacks],
  [The source station specifies the route for a packet to take as it crosses the
    Internet, in the hopes that this bypasses security measures that do not
    analyze the source routing information],
  [Discard all packets that use this option],

  emph[Tiny\ fragment\ attacks],
  [The intruder uses the IP fragmentation option to create extremely small
    fragments and force the TCP header information into a separate packet
    fragment],
  [Enforce rule that the first fragment of a packet must contain a predefined
    minimum amount of the transport header, also for all subsequent fragments],
)

==== Packet Filter Rules

First match wins: Rules are evaluated top-down; the first matching rule decides.
A default deny rule should be present in the last place so that
whatever is not explicitly allowed is dropped.

==== IPv6

/ Two rule sets: Dual-stack hosts are reachable via IPv4 and IPv6. An
  IPv4-only policy leaves IPv6 open -- including tunnels
  (6in4, Teredo).
/ No NAT by accident: IPv6 hosts have global addresses. Only a stateful
  default-deny inbound rule keeps them unreachable.
/ ICMPv6 is essential: Neighbor discovery, router advertisements and “Packet
  Too Big” must pass -- filter selectively #rfc(4890).
/ Extension headers & fragments: Long header chains can push the TCP header out of the
  first fragment -- drop such packets #rfc(7112).

=== Stateful Inspection Firewalls

For TCP connections, connection packets must be in
the right order (no ACK without SYN). A stateful inspection firewall checks
that. For UDP and some multi-port protocols (such as FTP),
the connection state is difficult to maintain, but may be
implemented in a basic manner.

=== Application Level Gateway

Also called an application proxy, it acts as a relay of application-level
traffic. It is more "secure" than a packet filter, but brings additional
processing overhead on each connection.

=== Circuit Level Gateway

#align(center, diagram(
  spacing: (12em, 0pt),
  node((0, 0), [Inner host], fill: colors-l.green, stroke: colors.green),
  edge("-|>", [TCP connection 1]),
  node(
    (1, 0),
    [Circuit level gateway],
    fill: colors-l.darkblue,
    stroke: colors.darkblue,
  ),
  edge("-|>", [TCP connection 2]),
  node((2, 0), [Outside host], fill: colors-l.red, stroke: colors.red),
))

A stand-alone system or a specialized function performed by an application-level
gateway for a limited number of applications.

As with an application gateway, it does not permit an end-to-end TCP connection.
Rather, the gateway sets up two TCP connections, one between itself and a TCP
user on an inner host and one between itself and a TCP user on an outside host.
Once the two connections are established, the gateway typically relays TCP
segments from one connection to the other without examining the contents. The
security function determines which connections are allowed.

Typical use case: setups in which the system administrator trusts the internal
users.

=== Next Generation Firewall

Hardware or software based component capable of detecting and blocking
complicated attacks by enforcing security measures at the protocol, port, and
application levels.

The main difference to a standard firewall is that the it performs more in-depth
inspection in smarter ways #icon-img("./img/nerd.png"). It inspects
the full packet by checking the signatures and payload of packets for any
anomalies or malware.

Next-generation firewalls also provide additional features such as Active
Directory integration support, SSH and TLS inspection, as well as malware
filtering based on reputation.

The common functionalities present in traditional firewalls -- such as state
inspection, virtual private networking, and packet filtering -- are also present in
next-generation firewalls.

=== Web Application Firewall (WAF)

#align(center, diagram(
  spacing: (4em, 0pt),
  node(
    (0, 0),
    [*Client*\ Browser/attacker],
    fill: colors-l.red,
    stroke: colors.red,
  ),
  edge("-|>"),
  node(
    (1, 0),
    [*WAF*\ Reverse proxy in the DMZ],
    fill: colors-l.darkblue,
    stroke: colors.darkblue,
  ),
  edge("-|>"),
  node(
    (2, 0),
    [*Web server*\ Application + DB],
    fill: colors-l.green,
    stroke: colors.green,
  ),
))

It inspects HTTP requests and responses: URL parameters, headers, cookies,
bodies -- after TLS termination.

It decides on Signatures (e.g. OWASP Core Rule Set), anomaly scoring, allow-lists of
valid input, rate limiting.

#tr[Limits:] False positives need tuning. It does
not fix the vulnerable code -- it is a virtual patch.

#todo[W7.1 S29,32]

= Network Security Designs

== DMZ Networks

Typical setup of a DMZ with
- External firewall for basic filtering
- Internal firewall for additional protection of the internal network
- Services that should be reachable form external are placed in the DMZ (with additional system hardening)

#todo[W7 S26 diagram]

#todo[W7 S28..]

== Air Gap

An air gap secures a server or network by
isolating it physically from other networks.

Examples:
- Critical infrastructure, e.g. industrial controllers for water supply or in a power plant.
- Medical equipment
- Military systems (e.g. a missile silo)
- Cold wallet for cryptocurrency

=== Data Transfer

An air gap network may still need a way to transfer data (e.g. system updates)
E.g. using removable media such as
USB stick, DVD, etc.

One needs to sanitize the media properly, it's a labor intensive process.

#todo[W7 S35 diagram]

=== Attack Vectors

- Infected USB sticks (Stuxnet)
- Malicious (or deceived) Insiders
- Compromised hardware (supply-chain attack)
- Van Eck phreaking, eavesdropping via electromagnetic emissions
