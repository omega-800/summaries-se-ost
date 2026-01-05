#import "./ankiconf.typ": *
#import "../lib.typ": *

#show: doc => conf(doc)

 #card(id: "1001", target-deck: "CN1", q: [SLAAC process], a:[
Mac address: *70:07:12:34:56:78*
+ Flip *7th* bit: 7#text([2], weight: "bold"):07:12:34:56:78. If it is "0", the address is locally administered and if it is "1", the address is globally unique.
+ Insert *FFFE* in the middle: 7207:12#text([FF:FE], weight: "bold")34:5678
+ Combine with link-local prefix: #text([FE80::], weight: "bold")7207:12FF:FE34:5678
New address: *FE80::7207:12FF:FE34:5678*
])

#card(id: "1002", target-deck: "CN1", q:   [Iterated query],a: [Local DNS server iteratively asks one server after the other, descending the domain name hierarchy step after step.])
#card(id: "1003", target-deck: "CN1", q:   [Recursive query],a: [Local DNS server asks root server for domain, which in turn asks the TLD server, which in turn asks the authoritative server etc. until the "call stack" unwinds and returns the fully resolved domain to the query sender.])

#card(id: "1004", target-deck: "CN1", q:   [DNS Record: A],a: [ hostname, IPv4 address])
#card(id: "1005", target-deck: "CN1", q:   [DNS Record: AAAA],a: [ hostname, IPv6 address ])
#card(id: "1006", target-deck: "CN1", q:   [DNS Record: CNAME],a: [ alias, canonical name ])
#card(id: "1007", target-deck: "CN1", q:   [DNS Record: NS],a: [ domain, hostname of authoritateive NS for this domain ])
#card(id: "1008", target-deck: "CN1", q:   [DNS Record: MX],a: [ domain, name of mailserver ])
#card(id: "1009", target-deck: "CN1", q:   [DNS Record: PTR],a: [ IP, domain ])

#card(id: "1010", target-deck: "CN1", q:   [TCP Segment size],a: [IPv4: 1440-1480b, IPv6: <=1460b])
#card(id: "1011", target-deck: "CN1", q:   [Multiplexing],a: [ Sending data from multiple sockets at sender. ])
#card(id: "1012", target-deck: "CN1", q:   [Demultiplexing],a: [ Delivering segments to correct socket at receiver. ])

#card(id: "1013", target-deck: "CN1", q:   [Maximum Segment Size],a: [ _MSS_ is the maximum payload size of a TCP packet. In IPv4 networks, typically, the size of the MSS is *1460 bytes* because it is encapsulated in the data link layer Ethernet frame size of *1500 bytes*. ])

#card(id: "1014", target-deck: "CN1", q:   [Retransmission timeout],a: [ If an acknowledgment is not received before the timer for a segment expires, a retransmission timeout occurs, and the segment is *automatically retransmitted*. ])

#card(id: "1015", target-deck: "CN1", q:   [Throughput],a: [ Denoted by _T_, is the amount of data that can be transmitted during a specified time. \ $T=W/R <= C_(L 3)$ ])
#card(id: "1016", target-deck: "CN1", q:   [Continuous sending],a: [ Sender transmits a stream of data packets in the given window size *without waiting for acknowledgments*. ])
#card(id: "1017", target-deck: "CN1", q:   [Delayed ACK],a: [ Receiver waits for a short period to acknowledge *multiple segments* with a *single ACK*. ])
#card(id: "1018", target-deck: "CN1", q:   [Selective ACK],a: [ Instead of asking for a retransmission of all missing segments, _SACK_ (specified by the receiver) allows the sender to send only the lost segments, significantly improving efficiency. ])

#card(id: "1019", target-deck: "CN1", q:   [Window Size],a: [ Denoted by _W_, is a _16 bit_ number sent with each packet by the receiver inside of the *rwnd* header field, indicating the amount of data he still has space for. ])
#card(id: "1020", target-deck: "CN1", q:   [Window scale],a: [ Used when the TCP window size needs to be increased beyond the traditional maximum of 65,535 bytes due to the demands of high-speed networks. \ If the handshake header includes the *window scale option* and the packet header includes the *scaling factor* then the effective window size is calculated as such: $"window size" * "scaling factor"$ ])

#card(id: "1021", target-deck: "CN1", q:   [Congestion control],a: [#image("./img/congestion_control.jpg")])
#card(id: "1022", target-deck: "CN1", q:   [Congestion window],a: [ #image("./img/cwnd.png") ])
#card(id: "1023", target-deck: "CN1", q:   [Sliding Window],a: [ Describes the process of the congestion window sliding to the right after receiving ACKs. ])
#card(id: "1024", target-deck: "CN1", q:   [Slow start],a: [ Gradual growth (doubling *cwnd* every *RTT*) within the congestion window size at the start of a connection or after a period of state of no activity. \ _Purpose_: Allows the sender to probe the available bandwidth in a controlled way. ])
#card(id: "1025", target-deck: "CN1", q:   [Congestion avoidance],a: [ Transition from sluggish start to congestion avoidance segment after accomplishing a threshold. \ _Purpose_: Maintains a truthful share of the community bandwidth even as heading off excessive congestion. ])
#card(id: "1026", target-deck: "CN1", q:   [Fast Retransmit],a: [ Detects packet loss through duplicate acknowledgments and triggers speedy retransmission without waiting for the *retransmission timeout*. \ _Purpose_: Speeds up the recuperation method with the aid of retransmitting lost packets without looking ahead to a timeout. ])
#card(id: "1027", target-deck: "CN1", q:   [Fast Recovery],a: [ Enters a quick healing state after detecting packet loss, lowering congestion window and transitioning to congestion avoidance. \ _Purpose_: Accelerates healing from congestion by way of avoiding a complete go back to slow begin after packet loss. ])
#card(id: "1028", target-deck: "CN1", q:   [AIMD],a: [ Adjusts the congestion window size based on network situations following the *Additive Increase, Multiplicative Decrease* principle. \ _Purpose_: Provides a balanced approach by way of linearly growing the window all through congestion avoidance and halving it on packet loss. ])
#card(id: "1029", target-deck: "CN1", q:   [Network layer packet size],a: [1500b])

#card(id: "1030", target-deck: "CN1", q:   [IPv6 Traffic Class],a: [Priority or type of traffic.])
#card(id: "1031", target-deck: "CN1", q:   [IPv6 Flow Label],a: [For identifying packets that require special handling, like real-time streaming.])

#card(id: "1032", target-deck: "CN1", q:   [IPv6 Extension Header],a: [Additional headers used in IPv6 to provide optional information. These can define aspects like payload size, routing, or fragmentation.])

#card(id: "1033", target-deck: "CN1", q:   [MTU],a: [Maximum Transmission Unit; the size of the largest packet that can be sent in a single frame over a network medium. IPv6 can handle larger MTUs compared to IPv4.])

#card(id: "1034", target-deck: "CN1", q:   [IPv6 Address: Link-local Address],a: [_FE80::/10_ Used for local communication between devices on the same network segment.])
#card(id: "1035", target-deck: "CN1", q:   [IPv6 Address: Global Unicast Address],a: [_2000::/3_ A globally routable address, these addresses are equivalent to public IPv4 addresses and can be reached over the internet.])
#card(id: "1036", target-deck: "CN1", q:   [IPv6 Address: Unique Local Address *(ULA)*],a: [_FC00::/7_ An address for local communication that is not routable on the global internet, similar to private addresses in IPv4.])
#card(id: "1037", target-deck: "CN1", q:   [IPv6 Address: Multicast Address],a: [_FF00::/8_ An address that enables a single packet to be sent to multiple destinations simultaneously.])
#card(id: "1038", target-deck: "CN1", q:   [IPv6 Address: Anycast Address],a: [An address assigned to multiple interfaces, where a packet sent to an anycast address is routed to the nearest (in terms of routing distance) interface.])
#card(id: "1039", target-deck: "CN1", q:   [IPv6 Address: Reserved Address],a: [Certain ranges in IPv6 are reserved for future use or specific functions. For example, addresses starting with _::/128_ are reserved for unspecified addresses.])
#card(id: "1040", target-deck: "CN1", q:   [IPv6 Address: Documentation Address],a: [_2001:DB8::/32_ Designated specifically for use in documentation and examples, ensuring it does not conflict with real-world addresses.])
#card(id: "1041", target-deck: "CN1", q:   [IPv6 Address: Link-local Multicast Address],a: [_FF02::/16_ Part of the link-local address range; it enables devices to communicate within a local network without requiring an external routing address.])
#card(id: "1042", target-deck: "CN1", q:   [IPv6 Address: Unspecified],a: [::/128])
#card(id: "1043", target-deck: "CN1", q:   [IPv6 Address: Loopback],a: [::1]) 
#card(id: "1044", target-deck: "CN1", q:   [IPv6 Address: IPv4-Embedded],a: [64:ff9b::/96]) 
#card(id: "1045", target-deck: "CN1", q:   [IPv6 Address: Discard-Only],a: [100::/64]) 
#card(id: "1046", target-deck: "CN1", q:   [IPv6 Address: Link-Local],a: [fe80::/10]) 
#card(id: "1047", target-deck: "CN1", q:   [IPv6 Address: Global Unicast],a: [2000::/3]) 
#card(id: "1048", target-deck: "CN1", q:   [IPv6 Address: Unique Local (ULA)],a: [fc00::/7]) 
#card(id: "1049", target-deck: "CN1", q:   [IPv6 Address: Multicast],a: [ff00::/8]) 
#card(id: "1050", target-deck: "CN1", q:   [IPv6 Address: All nodes, within scope 2 (link-local).],a: [ff02::1])
#card(id: "1051", target-deck: "CN1", q:   [IPv6 Address: All routers, within scope 2 (link-local).],a: [ff02::2])
#card(id: "1052", target-deck: "CN1", q:   [IPv6 Address: Solicited multicast address group],a: [ff02::1:ffxx:xxxx])
#card(id: "1053", target-deck: "CN1", q:   [IPv6 Address: A link-scoped multicast address used by a client to communicate with neighboring (i.e., on-link) relay agents and servers. All servers and relay agents are members of this multicast group.],a: [ff02::1:2])
#card(id: "1054", target-deck: "CN1", q:   [IPv6 Address: A site-scoped multicast address used by a relay agent to communicate with servers, either because the relay agent wants to send messages to all servers or because it does not know the unicast address of the servers.],a: [ff05::1:3])
#card(id: "1055", target-deck: "CN1", q: [Logical Link Control (LLC)],a: [ Handles communication between the network layer and the MAC sublayer. Provides a way to identify the protocol that is passed from the data link layer to the network layer. ])
#card(id: "1056", target-deck: "CN1", q: [Media Access Control  (MAC)],a: [ Data encapsulation: Includes frame assembly before transmission, frame parsing upon reception of a frame, data link layer MAC addressing and error detection. Media Access Control: Ethernet is a shared media and all devices can transmit at any time. ])
#card(id: "1057", target-deck: "CN1", q: [Collision domain vs broadcast domain],a: [ #image("./img/collision-domain.png") ])
#card(id: "1058", target-deck: "CN1", q:   [src-ip],a: [Use when: Many devices with different IPs send to one device with a single IP address])
#card(id: "1059", target-deck: "CN1", q:   [dst-ip],a: [Use when: A device with a single IP sends to many devices with different IP addresses])

// TODO: all of the rest
