#import "../lib.typ": *
#import "@preview/cetz:0.4.1": canvas, draw, matrix

#show: project.with(
  module: "CN2",
  name: "Computer Networks 2",
  semester: "FS26",
  language: "en",
)

= OSPF (Open Shortest Path First)

OSPF is an instance of a link state protocol designed for intra-domain routing in an IP network. OSPF gathers link state information from available routers and constructs a topology map of the network. It was introduced in 1989 and is widely used in large enterprise networks.

The used version of OSPF in IPv4 networks is known as OSPF version 2 (OSPFv2). OSPF for IPv6 networks is known as OSPFv3.

#todo("Table [AD] [Cost] [If] [Net]")

== Network hierarchy

OSPF provides the functionality to divide an intra-domain network into sub-domains, commonly referred to as areas. Every intra-domain must have a core area, referred to as a backbone area or top level area. All other areas connected to the backbone area are referred to as low-level areas. This means that the backbone area is in charge of summarizing the topology of one area to another area and vice versa. A core area is identified with Area ID 0. Areas are identified through a 32-bit area field. Area ID 0 is the same as 0.0.0.0.

#todo("Network diagram")

== Router classification

The routers are classified into four different types according to #rfc(2328)
#deftbl(
  [Internal Routers],
  [A router with all directly connected networks belonging to the same area. These routers run a single copy of the basic routing algorithm.],
  [Area Border Routers (ABR)],
  [A router that attaches to multiple areas. Area border routers run multiple copies of the basic algorithm, one copy for each attached area. Area border routers condense the topological information of their attached areas for distribution to the backbone. The backbone in turn distributes the information to the other areas.],
  [Backbone Routers],
  [A router that has an interface to the backbone area. This includes all routers that interface to more than one area (i.e., area border routers). However, backbone routers do not have to be area border routers. Routers with all interfaces connecting to the backbone area are supported.],
  [AS Boundary Routers (ASBR)],
  [A router that exchanges routing information with routers belonging to other Autonomous Systems. Such a router advertises AS external routing information throughout the Autonomous System. The paths to each AS boundary router are known by every router in the AS. This classification is completely independent of the previous classifications: AS boundary routers may be internal or area border routers, and may or may not participate in the backbone.],
)
#todo("Diagram")

== Network types

OSPF is designed to address four different types of networks:

_Point-to-point networks_ refer to connecting a pair of routers directly by an interface/link.

_Broadcast networks_ refer to networks such as LANs connected by a technology such as Ethernet. Broadcast networks, by nature, are multi-access where all routers in a broadcast network can receive a single transmitted packet. In such networks, a router is elected as a Designated Router (DR) and another as a Backup Designated Router (BDR).

_Non-broadcast multi-access networks (NBMA)_ are networks where more than two routers may be connected without broadcast capability. Such networks require an extra configuration to emulate the operation of OSPF on a broadcast network. Like broadcast networks, NBMA networks elect a DR and a BDR.

_Point-to-multipoint networks_ are also non-broadcast networks much like NBMA networks. However, OSPF’s mode of operation is different and is similar to point-to-point links. The two most commonly used network types are point-to-point networks and broadcast networks.
#todo("Diagram")

== Virtual links

_OSPF Design Rule 1_: *Area 0 has to be contiguous.* For example, if a backbone is partitioned into two parts due to a link failure, virtual links are used. In such a case, virtual links are tunnelled through a non-backbone area
#todo("Diagram")
_OSPF Design Rule 2_: *A non-backbone area has to be connected to the backbone area.* Virtual
links are used to connect an area to the backbone using a non-backbone (transit) area. Vir-
tual links are configured between two Area Border Routers.
#todo("Diagram")

== Link State Advertisement (LSA) Types

OSPF floods routing information such as link state advertisements. The scope of flooding of OSPF packets depends on the LSA types. The four most commonly known LSA types are:

#todo("Diagrams")

#deftbl(
  [Router LSA\ (Type Code=1)],
  [A Router LSA is the most basic link state advertisement that is generated for each interface. Every router generates a Router LSA that lists all the routers' outgoing interfaces. For each interface, the state and cost of the link are included. Such LSAs are generated for point-to-point links. *Flooding of Router LSAs is restricted to the area where they originate.*],
  [Network LSA\ (Type Code=2)],
  [Network LSAs are applicable in broadcast and non-broadcast networks where they are generated by the DR. A Network LSA represents a LAN. All attached routers and the DR are listed in the Network LSA. *Flooding of Network LSAs is also restricted to the area where they originate.*],
  [Network Summary LSA\ (Type Code=3)],
  [Area Border Routers (ABR) generate Network Summary LSAs that are used for advertising destinations outside an area. *Those LSAs are flooded in all the areas that are not totally stubby.*],
  [AS External LSA\ (Type Code=5)],
  [AS External LSAs are generated by Autnomous Sytem Boundary Routers. Destinations external to an OSPF AS are advertised using AS external LSAs. *AS external LSAs are flooded in all the areas that are neither stub nor totally stubby.*],
)

== Flooding

#todo("Diagram?")

OSPF sits directly on top of IP in the TCP/IP stack by using the IP protocol number 89. OSPF packets use the multicast destination MAC address 224.0.0.5. OSPF is required to provide its own reliable mechanism, instead of being able to use a reliable transport protocol such as TCP. OSPF addresses reliable delivery of packets through use of either an implicit or explicit acknowledgment.
- An _implicit acknowledgment_ means that a duplicate of the LSA as an update is sent back to the router from which it received the update.
- An _explicit acknowledgment_ means that the receiving router sends a link state acknowledgment packet on receiving a link state update.
Since a router may not receive acknowledgment from its neighbor to whom it sent a link state update message, a router is required to track a link state retransmission list of outstanding updates.
- An LSA is retransmitted, always as unicast, on a periodic basis until an acknowledgment is received, or the adjacency is no longer available.
- A router floods all its LSAs every 30 minutes, regardless of whether the content of the LSA such as the metric value has changed. Hence, the Link State Database (LSDB) is always synchronized between all routers in an area

== Packet format

OSPF has 5 packet types:

+ hello
+ database description (DBD or DD)
+ link state request (LSR)
+ link state update (LSU)
+ link state acknowledgement (LSAck)

=== Hello Packet

The primary purpose of the hello packet is to establish and maintain adjacencies. The hello packet is also used in the election process of the Designated Router and Backup Designated Router in broadcast networks. Moreover, it is used for negotiating optional capabilities.

#frame(
  (
    "Network Mask": (
      size: 32,
      desc: "This is the address mask of the router interface from which this packet is sent.",
    ),
  ),
  (
    "Hello Interval": (
      size: 16,
      desc: "This field designates the time difference in seconds between any two hello packets. The sending and the receiving routers are required to maintain the same value. Otherwise, a neighbor relationship between these two routers is not established. For point-to-point and broadcast networks, the default value is 10 sec, while for other network types the default value used is 30 sec.",
    ),
    Options: (
      size: 8,
      desc: "Options fields allow compatibility with a neighboring router to be checked.",
    ),
    Priority: (
      size: 8,
      desc: "This field is used when electing the designated router and the backup designated router.",
    ),
  ),
  (
    "Router Dead Interval": (
      size: 32,
      desc: "This is the length of time in which a router will declare a neighbor to be dead if it does not receive a hello packet. This interval needs to be larger than the hello interval. The neighbors also need to agree on the value of this parameter. This way, a routing packet that is received and does not match this field on a receiving router’s interface folder is dropped. The default value is typically four times the default value for the hello interval. In point-to-point networks and broadcast networks, the default value used is 40 sec while in other network types, the default value used is 120 sec.",
    ),
  ),
  (
    "Designated Router": (
      size: 32,
      desc: "DR (BDR) field lists the IP address of the interface of the DR (BDR) on the network, but not its router ID. If the DR (BDR) field is 0.0.0.0, this means that there is no DR (BDR).",
    ),
  ),
  ("Backup Designated Router": 32),
  (
    "Neighbors (4 bytes each)": (
      size: 32,
      desc: "This field is repeated for each router from which the originating router has received a valid Hello recently, meaning in the past Router Dead Interval.",
    ),
  ),
)

=== Database Description Packet

The database description packet contains a summary of all the LSAs (not the entire LSAs) that the neighboring router has in its LSDB. The OSPF database description packet has the following key features and fields:

#frame(
  (
    "Interface MTU": (
      size: 16,
      desc: "This field indicates the size of the largest transmission unit the interface can handle without fragmentation.",
    ),
    Options: (
      size: 8,
      desc: "Options fields consist of several bit-level fields. The most interesting one is the E-bit which is set when the attached area is capable of processing AS-external-LSAs.",
    ),
    "0 0 0 0 0": 5,
    "I": (
      size: 1,
      desc: "I-bit (initial-bit) is initialized to 1 for the initial packet that starts a database description session; for other packets for the same session, this field is set to 0.",
    ),
    "M": (
      size: 1,
      desc: "M-bit (more-bit) is used to indicate that this packet is not the last packet for the database description session by setting it to 1; the last packet for this session is set to 0.",
    ),
    "MS": (
      size: 1,
      desc: "MS-bit (master-slave bit) is used to indicate that the originator is the master by setting this field to 1, while the slave sets this field to 0.",
    ),
  ),
  (
    "DD Sequence Number": (
      size: 32,
      desc: "This field is used for incrementing the sequence numbers of packets from the side of the master during a database description session. The master sets the initial value for the sequence number.",
    ),
  ),
  (
    "LSA Headers": (
      size: 32,
      desc: "This field lists headers of the link state advertisements in the originator's link state database.",
    ),
  ),
)

=== Link State Request Packet

The link state request packet is used for pulling information. Once the database description has been received from a neighbor, a router knows which LSAs are not in its LSDB and will request the entire missing LSAs from that neighbor. The fields are repeated for each unique entry:

#frame(
  (
    "Link State Type": (
      size: 32,
      desc: "This field identifies a link state type such as a router or network.",
    ),
  ),
  (
    "Link State ID": (
      size: 32,
      desc: "This field is dictated by the link state type.",
    ),
  ),
  (
    "Advertising Router": (
      size: 32,
      desc: "This is the address of the router that has generated this LSA.",
    ),
  ),
)

=== Link State Update Packet

This packet is the answer to a Link State Request Packet. It contains the first field to be the number of LSAs followed by information on LSAs that match the LSA packet format. A link state update packet can contain one or more LSAs.

#frame(
  ("Number of LSAs": 32),
  ("LSAs": 32),
  ("...": 32),
  ("LSAs": 32),
)

=== Link State Acknowledgement Packet

Link State Acknowledgment Packets are OSPF packet type 5. Each newly received LSA must be acknowledged. This is usually done by sending Link State Acknowledgment packets. However, acknowledgments can also be accomplished implicitly by sending Link State Update packets.

Many acknowledgments may be grouped together into a single Link State Acknowledgment packet. Such a packet is sent back out the interface which received the LSAs.

A Link State Acknowledgment Packet contains a regular OSPF header with the type field set to 5 and a set of one or more LSA headers as payload.

#todo("descriptions, OSPF Header")

#frame(
  (Version: 8, Type: 8, "Packet Length": 16),
  ("Router ID": 32),
  ("Area ID": 32),
  ("CheckSum": 16, "AuType": 16),
  ("Authentication": 32),
  ("Authentication": 32),
  ("LSA Headers...": 32),
)

== Sub-Protocols

=== Hello Protocol

During initialization/activation, the hello protocol is used for neighbor discovery as well as to agree on several parameters before two routers become neighbors.
- When using the hello protocol, logical adjacencies are established for point-to-point, point-to-multipoint, and virtual link networks.
- For broadcast and NBMA networks, not all routers become logically adjacent. The hello protocol is used for electing Designated Routers and Backup Designated Routers.
While its name seems to imply that the hello protocol is just responsible for the initialization, it is actually much more than that. After initialization, for all network types the hello protocol is used for keeping alive connectivity which ensures bidirectional communication between neighbors. If the keep alive hello messages are not received within a certain time interval that was agreed upon during initialization, the link/connectivity between the routers is assumed to be not available.

=== Database Synchronization Protocol

#todo("chronos diagram")
#todo("shorten description")

Beyond basic initialization to discover neighbors, two adjacent routers need to build adjacencies. A complete link state advertisement of all links in the database of each router can be exchanged, but a special database description process is used to optimize this step. During the database description phase, only headers of link state advertisements are exchanged. Headers serve as adequate information to check if one side has the latest LSA. Since such a synchronization process may require exchange of header information about many LSAs, the database synchronization process allows for such exchanges to be split into multiple chunks.

These chunks are communicated using database description packets by indicating whether a chunk is an initial packet (using I-bit), or a continuation/more packet or last packet (using M-bit). One side needs to serve as a master (MS-bit) while the other side serves as a slave. The neighbor with the lower router ID becomes the slave.

+ Exchange Start: After two OSPF neighboring routers establish bi-directional communication and complete DR/BDR election (on multi-access networks), the routers transition to the exstart state. In this state, the neighboring routers establish a master/slave relationship (the router with the highest Router-ID becomes the master) and determine the initial database descriptor (DBD) sequence number to use while exchanging DBD packets.
+ Exchange: Once the master/slave relationship has been negotiated, the neighboring routers transition into the exchange state. In this state, the routers exchange DBD packets, which describe their entire link-state database.
+ Loading: When the last step of synchronization has been completed.
+ Full: For link-state requests and updates (entire LSAs), for which either side requires updated information, communication occurs in full state until there are no more link-state requests.

== Routing computation and Equal-Cost MultiPath

#todo("all this stuff")
