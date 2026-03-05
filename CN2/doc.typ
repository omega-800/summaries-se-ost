#import "../lib.typ": *
// fml i hate typst's dependency management
#import "@preview/cetz:0.3.4"
#import "@local/cntopo:0.0.1": fletcher-shapes, icons, to-fletcher-shapes

#show: project.with(
  module: "CN2",
  name: "Computer Networks 2",
  semester: "FS26",
  language: "en",
)


#let i = icons(
  stroke: colors.darkblue + 2pt,
  fill: colors.white,
  fill-inner: colors.darkblue,
  stroke-inner: colors.darkblue,
  flat: false,
)

#let (
  i-monitor,
  i-laptop,
  i-router,
  i-switch,
  i-l3-switch,
  i-server,
  i-cloud,
) = (
  i.pairs().map(((k, v)) => ("i-" + k, v)).to-dict()
)

#let (
  monitor,
  laptop,
  router,
  switch,
  l3-switch,
  server,
  cloud,
) = to-fletcher-shapes(i)

#let node = node.with(width: 3em, height: 3em)
#let diagram = diagram.with(
  node-stroke: colors.darkblue,
  node-fill: colors.white,
  // spacing: (1em, 1em),
)

#let albl = node.with(fill: colors.bg, stroke: none, width: 4em)
#let acld = node.with(
  inset: 2em,
  fill: colors.bg,
  shape: cloud,
)

= Routing

#link("https://frrouting.org/", "FOSS ftw")

#todo("Table [AD] [Cost] [If] [Net]")
```
Router# show ip route
Codes: I - IGRP derived, R - RIP derived, O - OSPF derived
       C - connected, S - static, E - EGP derived, B - BGP derived
       * - candidate default route, IA - OSPF inter area route
       E1 - OSPF external type 1 route, E2 - OSPF external type 2 route
Gateway of last resort is 131.119.254.240 to network 129.140.0.0
O E2 150.150.0.0 [160/5] via 131.119.254.6, 0:01:00, Ethernet2
E    192.67.131.0 [200/128] via 131.119.254.244, 0:02:22, Ethernet2
O E2 192.68.132.0 [160/5] via 131.119.254.6, 0:00:59, Ethernet2
O E2 130.130.0.0 [160/5] via 131.119.254.6, 0:00:59, Ethernet2
E    128.128.0.0 [200/128] via 131.119.254.244, 0:02:22, Ethernet2
E    129.129.0.0 [200/129] via 131.119.254.240, 0:02:22, Ethernet2
```

= OSPF (Open Shortest Path First)

OSPF is an instance of a link state protocol designed for intra-domain routing in an IP network. OSPF gathers link state information from available routers and constructs a topology map of the network. The version of OSPF used in IPv4 networks is known as OSPF version 2 (OSPFv2). OSPF for IPv6 networks is known as OSPFv3.

#todo("Interior Gateway Protocols IGP")

== SPF calculation

Every time there is a change in the network topology, OSPF needs to reevaluate its shortest path calculations.

- For each intra-area topology change, routers must rerun SPF.
- An inter-area topology change do not trigger the SPF recalculation.
  - The router determines the best paths for interarea routes based on the calculation of the best path towards the ABR.
  - The changes that are described in type 3 LSAs do not influence how the router reaches the ABR.
  - SPF recalculation is not needed.

== Network hierarchy

OSPF provides the functionality to divide an intra-domain network into sub-domains (areas). Areas are identified through a 32-bit area field. Area ID 0 is the same as 0.0.0.0. Every intra-domain must have a core area with area ID 0 (backbone area). All other areas connected to the backbone area are referred to as low-level areas. The backbone area is in charge of summarizing the topology of one area to another area and vice versa.

== Router classification

The routers are classified into four different types according to #rfc(2328)

#deftbl(
  [Internal Routers],
  [A router with all directly connected networks belonging to the same area. These routers run a single copy of the basic routing algorithm.],
  [Area Border\ Routers (ABR)],
  [A router that attaches to multiple areas. Area border routers run multiple copies of the basic algorithm, one copy for each attached area. Area border routers condense the topological information of their attached areas for distribution to the backbone. The backbone in turn distributes the information to the other areas.],
  [Backbone\ Routers],
  [A router that has an interface to the backbone area. This includes all routers that interface to more than one area (i.e., area border routers). However, backbone routers do not have to be area border routers. Routers with all interfaces connecting to the backbone area are supported.],
  [AS Boundary\ Routers (ASBR)],
  [A router that exchanges routing information with routers belonging to other Autonomous Systems. Such a router advertises AS external routing information throughout the Autonomous System. The paths to each AS boundary router are known by every router in the AS. This classification is completely independent of the previous classifications: AS boundary routers may be internal or area border routers, and may or may not participate in the backbone.],
)

#todo("fix cntopo-typ display issues")

#align(center, diagram(
  albl((0, 0), "Area 2", name: <a2>),
  node((1, 0), shape: router.with(label: "IR"), name: <r2>),
  acld(enclose: (<r2>, <a2>)),

  albl((6, 0), "Area 3", name: <a3>),
  node((5, 0), shape: router.with(label: "IR"), name: <r3>),
  acld(enclose: (<r3>, <a3>)),

  albl((8, 2.5), "Area 1", name: <a1>),
  node((7, 3), shape: router.with(label: ""), name: <r11>),
  node((9, 3), shape: router.with(label: "ASBR"), name: <r12>),
  node((8, 4), shape: router.with(label: "IR"), name: <r13>),
  acld(enclose: (<r11>, <r12>, <r13>, <a1>)),

  albl(
    (8.5, 0),
    [Link to Another\ Autonomous\ System (AS)],
    width: 8em,
    height: 4em,
    name: <as>,
  ),
  edge(<r12>, <as>),

  albl((3, 3), [Area 0\ OSPF\ Backbone], name: <a0>, width: 6em),
  node((2, 2), shape: router.with(label: "ABR"), name: <r01>),
  node((2, 4), shape: router.with(label: "BR"), name: <r02>),
  node((4, 2), shape: router.with(label: "ABR"), name: <r03>),
  node((4, 4), shape: router.with(label: "ABR"), name: <r04>),
  acld(enclose: (<r01>, <r02>, <r03>, <r04>, <a0>), inset: 0em),

  edge(<r2>, <r01>),
  edge(<r3>, <r03>),
  edge(<r11>, <r04>),

  edge(<r11>, <r12>),
  edge(<r13>, <r12>),
  edge(<r13>, <r11>),

  edge(<r01>, <r03>),
  edge(<r01>, <r02>),
  edge(<r04>, <r02>),
  edge(<r04>, <r03>),
))

== Network types

OSPF is designed to address four different types of networks:

_Point-to-point networks_ refer to connecting a pair of routers directly by an interface/link.

#align(center, diagram(
  node((0, 0), shape: router),
  edge(),
  node((2, 0), shape: router),
))

_Broadcast networks_ are multi-access where all routers in a broadcast network can receive a single transmitted packet. In such networks, a router is elected as a Designated Router (DR) and another as a Backup Designated Router (BDR).

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  diagram(
    node((1, 2), shape: router.with(label: "DROTHER"), name: <r1>),
    node((3, 2), shape: router.with(label: "DR"), name: <r2>),
    node((5, 2), shape: router.with(label: "BDR"), name: <r3>),
    node((7, 2), shape: router.with(label: "DROTHER"), name: <r4>),

    edge(<r1>, (1, 0)),
    edge(<r2>, (3, 0)),
    edge(<r3>, (5, 0)),
    edge(<r4>, (7, 0)),
    edge((0, 0), (8, 0)),
  ),
  diagram(
    node((0, 0), shape: router.with(label: "DR"), name: <r1>),
    node((2, 0), shape: router.with(label: "BDR"), name: <r2>),
    node((0, 2), shape: router.with(label: "DROTHER"), name: <r3>),
    node((2, 2), shape: router.with(label: "DROTHER"), name: <r4>),
    node((-1, 1), shape: router.with(label: "DROTHER"), name: <r5>),
    node((3, 1), shape: router.with(label: "DROTHER"), name: <r6>),

    node((1, 1), shape: switch, name: <s1>),

    edge(<r1>, <s1>),
    edge(<r2>, <s1>),
    edge(<r3>, <s1>),
    edge(<r4>, <s1>),
    edge(<r5>, <s1>),
    edge(<r6>, <s1>),
  ),
)

_Non-broadcast multi-access networks (NBMA)_ are networks where more than two routers may be connected without broadcast capability. Such networks require an extra configuration to emulate the operation of OSPF on a broadcast network. Like broadcast networks, NBMA networks elect a DR and a BDR.

#align(center, diagram(
  node((0, 0), shape: router.with(label: "DR"), name: <r1>),
  node((2, 0), shape: router.with(label: "BDR"), name: <r2>),
  node((-1, 1), shape: router.with(label: "DROTHER"), name: <r5>),
  node((3, 1), shape: router.with(label: "DROTHER"), name: <r6>),

  node(
    (1, 1),
    shape: cloud,
    [Frame Relay\ ATM X.25],
    name: <s1>,
    width: 8em,
    height: 5em,
  ),

  edge(<r1>, <s1>),
  edge(<r2>, <s1>),
  edge(<r5>, <s1>),
  edge(<r6>, <s1>),
))

_Point-to-multipoint networks_ are also non-broadcast networks much like NBMA networks. However, OSPF’s mode of operation is different and is similar to point-to-point links.

#align(center, diagram(
  node((5, 0), shape: router, name: <r2>),
  node((5, 1), shape: router, name: <r4>),
  node((5, 2), shape: router, name: <r6>),

  node((0, 1), shape: router, name: <s1>),

  edge(<r2>, <s1>),
  edge(<r4>, <s1>),
  edge(<r6>, <s1>),
))

=== Optimization on Non-Point-to-Point Networks

- Designated Router (DR) and Backup Designated Router (BDR) based on priority or router ID
- DR performs the LSA forwarding and LSDB synchronization tasks on behalf of all routers on the broadcast domain
- Each router establishes a FULL adjacency with the DR and the BDR by using the IPv4 multicast address 224.0.0.6
- The BDR performs the DR tasks only if the DR fails.

== Virtual links

- Virtual links cannot go through more than one area.
- Virtual links can only run through standard non-backbone areas. (not over stubby areas for example)

_OSPF Design Rule 1_: *Area 0 has to be contiguous.* For example, if a backbone is partitioned into two parts due to a link failure, virtual links are used. In such a case, virtual links are tunnelled through a non-backbone area

_OSPF Design Rule 2_: *A non-backbone area has to be connected to the backbone area.* Virtual links are used to connect an area to the backbone using a non-backbone (transit) area. Virtual links are configured between two Area Border Routers.


#table(
  columns: (1fr, 1fr),
  align: horizon + center,
  [Rule 1], [Rule 2],
  diagram(
    albl((0, 2), "Area 0", name: <a01>),
    acld(enclose: (<a01>,)),

    albl((0, 0), "Area 2", name: <a2>),
    node((0, 1), shape: router.with(label: "ABR", label-pos: left), name: <r2>),
    acld(enclose: (<a2>,)),

    albl((2, 2), "Area 0", name: <a02>),
    acld(enclose: (<a02>,)),

    albl((2, 0), "Area 1", name: <a1>),
    node(
      (2, 1),
      shape: router.with(label: "ABR", label-pos: right),
      name: <r1>,
    ),
    acld(enclose: (<a1>,)),

    albl((1, 4), "Area 3", name: <a3>),
    acld(enclose: (<a3>,)),

    node((0.5, 3), shape: router, name: <r3>),
    node((1.5, 3), shape: router, name: <r4>),

    albl(
      (1, 7),
      block(
        width: 15em,
      )[These routers used to be\ backbone router (prepartition)],
      name: <l>,
    ),
    edge(<r3>, <l>, shift: (0, -0.5), "<|-"),
    edge(<r4>, <l>, shift: (0, 0.5), "<|-"),
    edge(
      <r4>,
      <r3>,
      stroke: colors.purple + 1.5pt,
      bend: -90deg,
      "<|-|>",
      label: text(fill: colors.purple)[Virtual Link],
    ),
  ),
  diagram(
    albl((0, 2), "Area 1", name: <a01>),
    acld(enclose: (<a01>,)),

    albl((1, 0), "Area 2", name: <a2>),
    node(
      (0.5, 1),
      shape: router.with(label: "ABR", label-pos: left),
      name: <r2>,
    ),
    acld(enclose: (<a2>,)),

    albl((1, 4), "Area 0", name: <a3>),
    acld(enclose: (<a3>,)),

    node((0.5, 3), shape: router, name: <r3>),
    node((1.5, 3), shape: router, name: <r4>),
    node((0.5, 5), shape: router, name: <r5>),
    node((1.5, 5), shape: router, name: <r6>),

    edge(
      <r3>,
      <r2>,
      "<|-",
      label: box(fill: colors.bg, height: 2em, align(horizon, text(
        fill: colors.purple,
      )[Virtual Link])),
      label-side: right,
      stroke: colors.purple + 1.5pt,
    ),
  ),
)

== Passive Interfaces

The passive interface is used on interfaces where the router is not expected to form any OSPF neighbor adjacency. On a passive interface, the router stops sending and receiving OSPF Hello packets.

== Link State Advertisement (LSA) Types

OSPF floods routing information such as link state advertisements. The scope of flooding of OSPF packets depends on the LSA types. The four most commonly known LSA types are:

#todo("Diagrams")

#deftbl(
  [Router LSA\ (Type Code=1)],
  [Every router generates a Router LSA that lists all the routers' outgoing interfaces. For each interface, the state and cost of the link are included. Such LSAs are generated for point-to-point links. *Flooding of Router LSAs is restricted to the area where they originate.*],
  [Network LSA\ (Type Code=2)],
  [Network LSAs are applicable in broadcast and non-broadcast networks where they are generated by the DR. A Network LSA represents a LAN. All attached routers and the DR are listed in the Network LSA. *Flooding of Network LSAs is also restricted to the area where they originate.*],
  [Network Summary LSA\ (Type Code=3)],
  [Area Border Routers (ABR) generate Network Summary LSAs that are used for advertising destinations outside an area. *Those LSAs are flooded in all the areas that are not totally stubby.*],
  [ASBR Summary LSA\ (Type Code=4)],
  [Identifies the ASBR and provides a route to the ASBR. All traffic that is destined to an external autonomous system requires routing table knowledge of the ASBR that originated the external routes. Subsequent ABRs regenerate a type 4 LSA to flood it into their areas. #todo("external bit + diagram")],
  [AS External LSA\ (Type Code=5)],
  [AS External LSAs are generated by ASBRs and propagate the external networks within the OSPF domain. Destinations external to an OSPF AS are advertised using AS external LSAs. *AS external LSAs are flooded in all the areas that are neither stub nor totally stubby.*],
  [External LSA\ (Type Code=7)],
  [NSSA areas do not allow type 5 external LSAs #todo("link to areas")],
)

#todo("Summary (slide 38)")

== Route types

#deftbl(
  [Intra-area routes],
  [Are originated and learned in the same local area *(O)*],
  [Inter-area routes],
  [Originate in other areas and are inserted into the local area to which your router belongs *(O IA)*],
  [External routes],
  [*(O E1 or O E2)*],
)

== Flooding

#todo("Diagram?")

OSPF sits directly on top of IP in the _TCP/IP stack_ by using the IP protocol number *89*. OSPF packets use the *multicast destination MAC address 224.0.0.5*. OSPF is required to provide its own reliable mechanism, instead of being able to use a reliable transport protocol such as TCP. OSPF addresses reliable delivery of packets through use of either an implicit or explicit acknowledgment.
- An _implicit acknowledgment_ means that a duplicate of the LSA as an update is sent back to the router from which it received the update.
- An _explicit acknowledgment_ means that the receiving router sends a link state acknowledgment packet on receiving a link state update.
Since a router may not receive acknowledgment from its neighbor to whom it sent a link state update message, a router is required to track a link state retransmission list of outstanding updates.
- An *LSA is retransmitted*, always as unicast, on a periodic basis *until an acknowledgment is received*, or the adjacency is no longer available.
- A router *floods all its LSAs every 30 minutes*, regardless of whether the content of the LSA such as the metric value has changed. Hence, the Link State Database (LSDB) is always synchronized between all routers in an area

== Packet format

#todo("packet overview (slide 16)")
#todo("OSPF LSAs & LSDB Flooding (slide 17)")

OSPF has 5 packet types:

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  [Packet Type], [Function], [Transmission Mode], [Address],
  [Hello], [Discovery/Maintain], [Usually Multicast], [244.0.0.5\*],
  [DBD], [Database Summary], [Unicast], [Neighbor IP],
  [LSR], [Request LSA], [Unicast], [Neighbor IP],
  [LSU], [Link State Update], [Multicast/Unicast], [244.0.0.5/.6\* or Unicast],
  [LSAck], [Acknowledgement], [Multicast/Unicast], [244.0.0.5/.6\* or Unicast],
)
\* 244.0.0.5 for all routers, 244.0.0.6 for DR/BDR

=== Hello Packet (Hello)

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

=== Database Description Packet (DBD)

- Includes
  - link-state type
  - address of advertising router
  - link-cost
  - sequence number
- Unicast

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

=== Link State Request Packet (LSR)

- Typically triggered after DBD
- Requests specific LSAs from neighbors (unicast)

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

=== Link State Update Packet (LSU)

- Carrying one or more LSAs
- Flooding of LSAs (multicast)
- Sending LSA responses to LSRs (unicast)
- Ensuring all routers have same view
- Implicit acknowledgement

This packet is the answer to a Link State Request Packet. It contains the first field to be the number of LSAs followed by information on LSAs that match the LSA packet format. A link state update packet can contain one or more LSAs.

#frame(
  ("Number of LSAs": 32),
  ("LSAs": 32),
  ("...": 32),
  ("LSAs": 32),
)

=== Link State Acknowledgement Packet (LSAck)

- Explicitly acknowledge received LSAs
- Make LSA flooding reliable (multicast)
- Unicast if acknowledging direct LSU
- Multiple LSAs acknowledgment possible

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

During initialization/activation, the hello protocol is used for *neighbor discovery* as well as to *agree on several parameters* before two routers become neighbors.

- When using the hello protocol, *logical adjacencies are established* for point-to-point, point-to-multipoint, and virtual link networks.
- For broadcast and NBMA networks, not all routers become logically adjacent. The hello protocol is used for *electing Designated Routers and Backup Designated Routers*.

After initialization, for all network types the hello protocol is used for *keeping alive connectivity* which ensures bidirectional communication between neighbors. If the keep alive hello messages are not received within a certain time interval that was agreed upon during initialization, the link/connectivity between the routers is assumed to be not available.

=== Database Synchronization Protocol

#todo("slides 18/19/21/23")

#grid(
  columns: 2,
  [Beyond basic initialization to discover neighbors, two adjacent routers need to build adjacencies. A complete link state advertisement of all links in the database of each router can be exchanged, but a special database description process is used to optimize this step. During the database description phase, only *headers of link state advertisements are exchanged*. Headers serve as adequate information to check if one side has the latest LSA. Since such a synchronization process may require exchange of header information about many LSAs, the database synchronization process allows for such exchanges to be *split into multiple chunks*.

    These chunks are communicated using database description packets by indicating whether a chunk is an *initial packet (using I-bit)*, or a *continuation/more packet or last packet (using M-bit)*. One side needs to serve as a *master (MS-bit)* while the other side serves as a *slave*. The neighbor with the lower router ID becomes the slave.

    + _Exchange Start:_ Neighboring routers establish a master/slave relationship and determine the initial database descriptor (DBD) sequence number to use while exchanging DBD packets.
    + _Exchange:_ The routers exchange DBD packets, which describe their entire link-state database.
    + _Loading:_ When the last step of synchronization has been completed.
    + _Full:_ For link-state requests and updates (entire LSAs), for which either side requires updated information, communication occurs in full state until there are no more link-state requests.
  ],
  chronos.diagram({
    _par(
      "a",
      display-name: [Router ID\ 10.1.2.254],
      shape: "custom",
      custom-image: cetz.canvas(length: 1.5em, {
        i-router()
      }),
    )
    _par(
      "b",
      display-name: [Router ID\ 10.1.1.254],
      shape: "custom",
      custom-image: cetz.canvas(length: 1.5em, {
        i-router()
      }),
    )

    _seq("b", "a", comment: "Hello (DR = 0.0.0.0, I see = 0)")
    _seq("a", "b", comment: "Hello (DR = 10.1.2.254, I see = 10.1.1.254)")

    _seq("b", "a", comment: "DD (Seq = x, Init, More, Master)")
    _seq("a", "b", comment: "DD (Seq = y, Init, More, Master)")

    _seq("b", "a", comment: "DD (Seq = y, More, Slave)")
    _seq("a", "b", comment: "DD (Seq = y + 1, Init, More, Master)")

    _seq("b", "a", comment: "DD (Seq = y+1, More, Slave)")

    _seq("b", "a", dashed: true, slant: 0, start-tip: "", end-tip: "")
    _seq("b", "a", dashed: true, slant: 0, start-tip: "", end-tip: "")
    _seq("b", "a", dashed: true, slant: 0, start-tip: "", end-tip: "")

    _seq("a", "b", comment: "DD (Seq = y+n, NoMore, Master)")
    _seq("b", "a", comment: "DD (Seq = y+n, NoMore, Slave)")
    _seq("b", "a", comment: "LS Request")
    _seq("a", "b", comment: "LS Update")

    _seq("b", "a", comment: "LS Request")
    _seq("a", "b", comment: "LS Update")
  }),
)

== Routing computation and Equal-Cost MultiPath

#todo("default metrics (slide 55)")

#todo("all this stuff")

LSAs type 1 and 2 are flooded throughout an area. This allows every router in an area to build link state databases with identical topological information.
- Shortest path computation based on Dijkstra’s algorithm is performed at each router for every known destination based on the directional graph determined from the link state database.
- The link cost used for each link is the metric value advertised in the link state advertisement packet. The value can be between 1 and 65 535
- Dijkstra-based shortest path computation using link state information is applied only within an area. For routing updates between areas, information from one area is summarized using Summary LSAs without providing detailed link information.
The next hop is extracted from the shortest path computation to update the routing table and
subsequently, the forwarding table.
- Routing table entries are for destinations identified through hosts or subnets or simply IP prefixes with CIDR notation, not in terms of end routers.
- Because of CIDR, multiple similar route entries are possible, eg. 10.1.64.0/24 vs 10.1.64.0/18. To select the route preferred by an arriving packet, OSPF uses a best route selection process (most specific match).
- In case there are multiple paths available after this step, the second step selects the route where an intra-area path is given preference over an inter-area path, which in turn gives preference over external paths for routes learned externally.

=== Equal-cost multipath (ECMP)

Equal-cost multipath (ECMP) means that if two paths have the same lowest cost, then the outgoing link (next hop) for both can be listed in the routing table so that traffic can be equally split. The original Dijkstra’s algorithm generates only one shortest path even if multiple shortest paths are available. To capture multiple shortest paths, where available, Dijkstra’s algorithm is slightly modified.

#todo("example diagram")

#todo("check this")

The router implementation handles the ECMP path selection on a per-flow basis rather than on a per-packet basis. The ECMP path selection is based on the hash of certain fields of the IP packet without having to maintain states at routers.

=== Stub areas and stub networks

- Stubby = Eliminates all external routes (type 5)
- Totally stubby = Additionally eliminates all inter-area routes (type 3)

#deftbl(
  [Area 0\ Backbone Area],
  [
    - Has to be connected to all of the other areas.
    - Must always be contiguous
    - Generally, end users are not found within a backbone area
  ],
  [Area 1\ Stub Area],
  [
    - Eliminates all external routes (type 5)
    - Creates a default route
    - Cannot contain ASBRs
  ],
  [Area 2\ Standart Area],
  [
    - All routes present
  ],
  [Area 3\ Totally Stubby Area],
  [
    - Eliminates all external routes (type 5)
    - Eliminates all inter-area routes (type 3)
    - Creates a default route
    - Cannot contain ASBRs
  ],
  [Area 4 (NSSA)\ Not so Stubby Area],
  [
    - Allows injection of external routes into a stub area
    - Eliminates all external routes\* (type 5)
    - No default route
    - Creates own area type 7 LSA

      \* advertises area 4 ASBR redistributed external routes as LSA type 7 in area 4 itself. When traversing to a different OSPF area, it transforms them to a regular type 5 LSA
  ],
  [Area 5 (Totally NSSA)\ Totally Not so Stubby Area],
  [
    - Eliminates all external routes\* (type 5)
    - Eliminates all inter-area routes (type 3)
    - Creates a default route
    - Creates own area type 7 LSA

      \* advertises area 5 ASBR redistributed external routes as LSA type 7 in area 5 itself. When traversing to a different OSPF area, it transforms them to a regular type 5 LSA
  ],
)

#todo("more context / diagrams? (slides 41)")


=== Route selection

#todo("shorten")

When using OSPF routing hierarchy, the following rules apply:
- If the source and destination addresses of a packet reside within the same area, intra-area routing is used. Intra-area routes in OSPF are described by router (type code = 1) and network (type code = 2) LSAs. When displayed in the OSPF routing table, these types of intra-area routes are designated with an O.
- If the source and destination addresses of a packet reside within different areas, but are still within the AS, inter-area routing is used. These types of routes are described by network (type 3) summary LSAs. When routing packets between two nonbackbone areas, the backbone is used. This means that inter-area routing has pieces of intra-area routing along its path, for example:
  + An intra-area path is used from the source router to the area border router.
  + The backbone is then used from the source area to the destination area.
  + An intra-area path is used from the destination area’s area border router to the destination.
  When you put these three routes together, you have an inter-area route. Of course, the
  SPF algorithm calculates the lowest cost between these two points. When displayed in the
  OSPF routing table, these types of routes are indicated with an O IA.
- If the destination address of a packet resides outside the AS, external routing is used. External routing information are injected into OSPF through redistribution from another routing protocol. The AS boundary routers (ASBRs) flood the external route information throughout the AS. Every router receives this information, with the exception of stub areas. The types of external routes used in OSPF are as follows:
  - E1 routes: E1 route’s costs are the sum of internal and external (remote AS) OSPF metrics. If a packet is destined for another AS, an E1 route takes the remote AS metric and adds all internal OSPF costs. They are identified by the E1 designation within the OSPF routing table.
  - E2 routes: E2 routes are the default external routes for OSPF. They do not add the internal OSPF metrics. Multiple routes to the same destination use the following order of preference: intra-area, inter-area, E1, and E2.


OSPF will first look at the “type of path” to decide and secondly look at the metric. On equal types path cost will decide by the preferred path list for OSPF:

+ Intra-Area (O)
+ Inter-Area (O IA)
+ External Type 1 (E1)
+ NSSA Type 1 (N1)
+ External Type 2 (E2)
+ NSSA Type 2 (N2)

=== Route summarization

Route summarization helps solve two major challenges

- Large routing tables
- Frequent LSA flooding throughout the autonomous system

With route summarization, the ABRs or ASBRs consolidate multiple routes into a single advertisement

- Route summarization requires a good addressing plan
- Subnets in areas should be assigned contiguously to ensure that these addresses can be summarized into a minimal number of summary addresses

Summarization is only allowed on ASBRs and ABRs

#todo("ABR/ASBR (slide 50-53)")

= IS-IS

Intermediate System to Intermediate System.

- Widely used (especially in ISP networks)
- Fast convergence
- Equal Cost Multipath(ECMP) Load Balancing
- IS-IS supports different protocol suites #rfc(1195)

ES and IS:

- End-host devices are called End Systems (ES)
- Routers are called Intermediate Systems (IS)

#todo("Similarities with OSPF (slides 10)")

ISIS considered to be more scalable and better suited for large and complex networks. OSPF might struggle with very large networks, especially in one single area.

- IS-IS: groups updates into one LSP
- OSPF: many small LSA updates

ISIS detects a failure faster

== Advantages

- Used in most of the large ISPs because
- Simpler than OSPF
- Well-positioned for IPv6
- Scalability
  - Less "chatty"
  - TLVs instead of new LSPs
- Stability
  - IS-IS operates directly over the data link layer
  - SPF calculations use NSAP System IDs
  - Multiple protocols supported, but treated as metadata attributes

== Extending OSPF

- Classical OSPF is not easy to extend to add new features
  - They require the creation of a new LSA
  - OSPF version 2 was developed exclusively for IPv4
  - #rfc(7684) introduces Opaque LSAs

== Addressing

#todo("slides 18/19/20")

$
  underbrace(49.0011., "Area ID")underbrace(0000.0000.0003., "System ID")underbrace(00, "NSEL")
$

== PDU

- Hello
- LSP
- PSNP
- CSNP

#todo("the rest")

= BGP

= BGP Advanced

= Network Design

= MPLS

= Overlay Technologies

= EVPN / VXLAN

= CND

= QoS
