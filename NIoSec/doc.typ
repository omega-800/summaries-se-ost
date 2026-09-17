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

#table(
  columns: (auto, 1fr),
  [Communication layers], [Security protocols],
  [Application layer], [Web Application Security, VoIP Security, SW Security],
  [Transport layer], [TLS ],
  [Network layer], [IPsec],
  [Data Link layer], [L2TP, IEEE 802.1X, IEEE 802.1AE, IEEE 802.11i (WPA2)],
  [Physical layer], [Quantum Key Exchange],
)

The CIA triad is a foundational information-security model stating that
systems should protect:
/ Confidentiality: Keeping information secret
/ Integrity: Keeping information correct and unaltered
/ Availability: Ensuring information and systems remain accessible

Additional desired properties:
/ Authenticity: Adversary cannot claim to be someone else
/ Accountability/Non-repudiation: Actions can be traced to actor

#todo[W1 slides 15,16]

= TLS

SSL and TLS are protocols for internet handshakes and encrypted transmission.
Secure Socket Layer (SSL) came first, then after v3.0 it became Transport Layer Security (TLS),
currently v1.3. People still use SSL as a term, even though technically it’s now
TLS.

/ TLS 1.2: Introduced authenticated encryption, which is the most modern form of
  encryption. It's a more flexible protocol, lots of TLS extensions, the
  hashing function has been improved.
/ TLS 1.3: The protocol has been redesigned to make it faster. A lot of the old
  ciphers have been removed to make it more secure. It only supports
  authenticated encryption (AEAD).

#todo[W1 slides 22]

== Specification

=== Record protocol

All TLS packets are sent using the record protocol. This header is attached to
every single message.

#todo[
  slides 23
  frame((
  Type: 1,
  Version: 2,
  Length: 2,
  ))
]

=== Subprotocols

#todo[slides 24]

=== Handshake

#todo[slides 25-26]

== Modern TLS Variants

=== DTLS

#todo[]

=== QUIC

#todo[]

== Attacks

=== Heartbleed

#todo[]

=== Syn Flooding

#todo[]

=== TCP Reset

#todo[]

=== FREAK

#todo[]
