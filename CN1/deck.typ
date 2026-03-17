#import "@local/tanki:0.0.1": add-deck, add-note
#import "../lib.typ": *

#let did = 69421
#add-deck(did, "CN1", "Computer Networks 1")
#let new-note = add-note.with(deck: did)

#card(id: "1001", (
  [SLAAC process],
  [
    Mac address: *70:07:12:34:56:78*
    + Flip *7th* bit: 7#text([2], weight: "bold"):07:12:34:56:78. If it is "0", the address is locally administered and if it is "1", the address is globally unique.
    + Insert *FFFE* in the middle: 7207:12#text([FF:FE], weight: "bold")34:5678
    + Combine with link-local prefix: #text([FE80::], weight: "bold")7207:12FF:FE34:5678
    New address: *FE80::7207:12FF:FE34:5678*
  ],
))

#card(
  id: "1002",

  (
    [Iterated query],
    [Local DNS server iteratively asks one server after the other, descending the domain name hierarchy step after step.],
  ),
)
#card(
  id: "1003",

  (
    [Recursive query],
    [Local DNS server asks root server for domain, which in turn asks the TLD server, which in turn asks the authoritative server etc. until the "call stack" unwinds and returns the fully resolved domain to the query sender.],
  ),
)

#card(
  id: "1004",

  ([DNS Record: A], [ hostname, IPv4 address]),
)
#card(
  id: "1005",

  ([DNS Record: AAAA], [ hostname, IPv6 address ]),
)
#card(
  id: "1006",

  ([DNS Record: CNAME], [ alias, canonical name ]),
)
#card(
  id: "1007",

  ([DNS Record: NS], [ domain, hostname of authoritateive NS for this domain ]),
)
#card(
  id: "1008",

  ([DNS Record: MX], [ domain, name of mailserver ]),
)
#card(id: "1009", ([DNS Record: PTR], [ IP, domain ]))

#card(
  id: "1010",

  ([TCP Segment size], [IPv4: 1440-1480b, IPv6: <=1460b]),
)
#card(
  id: "1011",

  ([Multiplexing], [ Sending data from multiple sockets at sender. ]),
)
#card(
  id: "1012",

  ([Demultiplexing], [ Delivering segments to correct socket at receiver. ]),
)

#card(
  id: "1013",

  (
    [Maximum Segment Size],
    [ _MSS_ is the maximum payload size of a TCP packet. In IPv4 networks, typically, the size of the MSS is *1460 bytes* because it is encapsulated in the data link layer Ethernet frame size of *1500 bytes*. ],
  ),
)

#card(
  id: "1014",

  (
    [Retransmission timeout],
    [ If an acknowledgment is not received before the timer for a segment expires, a retransmission timeout occurs, and the segment is *automatically retransmitted*. ],
  ),
)

#card(
  id: "1015",

  (
    [Throughput],
    [ Denoted by _T_, is the amount of data that can be transmitted during a specified time. \ $T=W/R <= C_(L 3)$ ],
  ),
)
#card(
  id: "1016",

  (
    [Continuous sending],
    [ Sender transmits a stream of data packets in the given window size *without waiting for acknowledgments*. ],
  ),
)
#card(
  id: "1017",

  (
    [Delayed ACK],
    [ Receiver waits for a short period to acknowledge *multiple segments* with a *single ACK*. ],
  ),
)
#card(
  id: "1018",

  (
    [Selective ACK],
    [ Instead of asking for a retransmission of all missing segments, _SACK_ (specified by the receiver) allows the sender to send only the lost segments, significantly improving efficiency. ],
  ),
)

#card(
  id: "1019",

  (
    [Window Size],
    [ Denoted by _W_, is a _16 bit_ number sent with each packet by the receiver inside of the *rwnd* header field, indicating the amount of data he still has space for. ],
  ),
)
#card(
  id: "1020",

  (
    [Window scale],
    [ Used when the TCP window size needs to be increased beyond the traditional maximum of 65,535 bytes due to the demands of high-speed networks. \ If the handshake header includes the *window scale option* and the packet header includes the *scaling factor* then the effective window size is calculated as such: $"window size" * "scaling factor"$ ],
  ),
)

#card(id: "1021", (
  [Congestion control],
  image(
    "./img/congestion_control.jpg",
  ),
))
#card(id: "1022", (
  [Congestion window],
  image(
    "./img/cwnd.png",
  ),
))
#card(
  id: "1023",

  (
    [Sliding Window],
    [ Describes the process of the congestion window sliding to the right after receiving ACKs. ],
  ),
)
#card(
  id: "1024",

  (
    [Slow start],
    [ Gradual growth (doubling *cwnd* every *RTT*) within the congestion window size at the start of a connection or after a period of state of no activity. \ _Purpose_: Allows the sender to probe the available bandwidth in a controlled way. ],
  ),
)
#card(
  id: "1025",

  (
    [Congestion avoidance],
    [ Transition from sluggish start to congestion avoidance segment after accomplishing a threshold. \ _Purpose_: Maintains a truthful share of the community bandwidth even as heading off excessive congestion. ],
  ),
)
#card(
  id: "1026",

  (
    [Fast Retransmit],
    [ Detects packet loss through duplicate acknowledgments and triggers speedy retransmission without waiting for the *retransmission timeout*. \ _Purpose_: Speeds up the recuperation method with the aid of retransmitting lost packets without looking ahead to a timeout. ],
  ),
)
#card(
  id: "1027",

  (
    [Fast Recovery],
    [ Enters a quick healing state after detecting packet loss, lowering congestion window and transitioning to congestion avoidance. \ _Purpose_: Accelerates healing from congestion by way of avoiding a complete go back to slow begin after packet loss. ],
  ),
)
#card(
  id: "1028",

  (
    [AIMD],
    [ Adjusts the congestion window size based on network situations following the *Additive Increase, Multiplicative Decrease* principle. \ _Purpose_: Provides a balanced approach by way of linearly growing the window all through congestion avoidance and halving it on packet loss. ],
  ),
)
#card(
  id: "1029",

  ([Network layer packet size], [1500b]),
)

#card(
  id: "1030",

  ([IPv6 Traffic Class], [Priority or type of traffic.]),
)
#card(
  id: "1031",

  (
    [IPv6 Flow Label],
    [For identifying packets that require special handling, like real-time streaming.],
  ),
)

#card(
  id: "1032",

  (
    [IPv6 Extension Header],
    [Additional headers used in IPv6 to provide optional information. These can define aspects like payload size, routing, or fragmentation.],
  ),
)

#card(
  id: "1033",

  (
    [MTU],
    [Maximum Transmission Unit; the size of the largest packet that can be sent in a single frame over a network medium. IPv6 can handle larger MTUs compared to IPv4.],
  ),
)

#card(
  id: "1034",

  (
    [IPv6 Address: Link-local Address],
    [_FE80::/10_ Used for local communication between devices on the same network segment.],
  ),
)
#card(
  id: "1035",

  (
    [IPv6 Address: Global Unicast Address],
    [_2000::/3_ A globally routable address, these addresses are equivalent to public IPv4 addresses and can be reached over the internet.],
  ),
)
#card(
  id: "1036",

  (
    [IPv6 Address: Unique Local Address *(ULA)*],
    [_FC00::/7_ An address for local communication that is not routable on the global internet, similar to private addresses in IPv4.],
  ),
)
#card(
  id: "1037",

  (
    [IPv6 Address: Multicast Address],
    [_FF00::/8_ An address that enables a single packet to be sent to multiple destinations simultaneously.],
  ),
)
#card(
  id: "1038",

  (
    [IPv6 Address: Anycast Address],
    [An address assigned to multiple interfaces, where a packet sent to an anycast address is routed to the nearest (in terms of routing distance) interface.],
  ),
)
#card(
  id: "1039",

  (
    [IPv6 Address: Reserved Address],
    [Certain ranges in IPv6 are reserved for future use or specific functions. For example, addresses starting with _::/128_ are reserved for unspecified addresses.],
  ),
)
#card(
  id: "1040",

  (
    [IPv6 Address: Documentation Address],
    [_2001:DB8::/32_ Designated specifically for use in documentation and examples, ensuring it does not conflict with real-world addresses.],
  ),
)
#card(
  id: "1041",

  (
    [IPv6 Address: Link-local Multicast Address],
    [_FF02::/16_ Part of the link-local address range; it enables devices to communicate within a local network without requiring an external routing address.],
  ),
)
#card(
  id: "1042",

  ([IPv6 Address: Unspecified], [::/128]),
)
#card(id: "1043", ([IPv6 Address: Loopback], [::1]))
#card(
  id: "1044",

  ([IPv6 Address: IPv4-Embedded], [64:ff9b::/96]),
)
#card(
  id: "1045",

  ([IPv6 Address: Discard-Only], [100::/64]),
)
#card(
  id: "1046",

  ([IPv6 Address: Link-Local], [fe80::/10]),
)
#card(
  id: "1047",

  ([IPv6 Address: Global Unicast], [2000::/3]),
)
#card(
  id: "1048",

  ([IPv6 Address: Unique Local (ULA)], [fc00::/7]),
)
#card(
  id: "1049",

  ([IPv6 Address: Multicast], [ff00::/8]),
)
#card(
  id: "1050",

  ([IPv6 Address: All nodes, within scope 2 (link-local).], [ff02::1]),
)
#card(
  id: "1051",

  ([IPv6 Address: All routers, within scope 2 (link-local).], [ff02::2]),
)
#card(
  id: "1052",

  ([IPv6 Address: Solicited multicast address group], [ff02::1:ffxx:xxxx]),
)
#card(
  id: "1053",

  (
    [IPv6 Address: A link-scoped multicast address used by a client to communicate with neighboring (i.e., on-link) relay agents and servers. All servers and relay agents are members of this multicast group.],
    [ff02::1:2],
  ),
)
#card(
  id: "1054",

  (
    [IPv6 Address: A site-scoped multicast address used by a relay agent to communicate with servers, either because the relay agent wants to send messages to all servers or because it does not know the unicast address of the servers.],
    [ff05::1:3],
  ),
)
#card(
  id: "1055",

  (
    [Logical Link Control (LLC)],
    [ Handles communication between the network layer and the MAC sublayer. Provides a way to identify the protocol that is passed from the data link layer to the network layer. ],
  ),
)
#card(
  id: "1056",

  (
    [Media Access Control  (MAC)],
    [ Data encapsulation: Includes frame assembly before transmission, frame parsing upon reception of a frame, data link layer MAC addressing and error detection. Media Access Control: Ethernet is a shared media and all devices can transmit at any time. ],
  ),
)
#card(
  id: "1057",

  (
    [Collision domain vs broadcast domain],
    image("./img/collision-domain.png"),
  ),
)
#card(
  id: "1058",

  (
    [src-ip],
    [Use when: Many devices with different IPs send to one device with a single IP address],
  ),
)
#card(
  id: "1059",

  (
    [dst-ip],
    [Use when: A device with a single IP sends to many devices with different IP addresses],
  ),
)

// TODO: all of the rest
