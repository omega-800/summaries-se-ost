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
  stroke: colors.blue + 2pt,
  fill: colors.darkblue,
  fill-inner: colors.white,
  stroke-inner: colors.white,
  flat: false,
)

#let (
  i-monitor,
  i-router,
  i-switch,
  i-l3-switch,
  i-server,
  i-cloud,
) = (
  i.pairs().map(((k, v)) => ("i-" + k, v)).to-dict()
)

#let dec = dec.with(prefix: false)


#let (
  monitor,
  router,
  switch,
  l3-switch,
  server,
  cloud,
) = to-fletcher-shapes(i)

#let cloud = cloud.with(override-color: true)

#let node = node.with(width: 4em, height: 4em)
#let diagram = diagram.with(
  node-stroke: colors.darkblue,
  node-fill: colors.white,
  spacing: (.5em, .5em),
)

#let albl = node.with(fill: colors.bg, stroke: none, width: 4em)
#let acld = node.with(
  inset: 2em,
  fill: colors.bg,
  shape: cloud,
)

= Routing

#link("https://frrouting.org/", "FOSS ftw")

== Administrative Distance (AD)

#grid(
  columns: 2,
  [
    When multiple sources exist for routing information in a router, such as static routes and BGP, a Cisco router uses the concept of administrative distances to prefer one routing source to the others. The protocol with the lowest administrative distance wins. The accepted best route is then installed in the routing table.

    The administrative distances of the routing protocols are shown in the following table:

    #todo([Table [AD] [Cost] [If] [Net]])
  ],
  table(
    columns: 2,
    table-header([Protocol], [AD]), [RIP v1 and v2],
    [120], [EIGRP Internal],
    [90], [EIGRP External],
    [170], [OSPF],
    [110], [Integrated ISIS],
    [115], [BGP Internal],
    [200], [BGP External],
    [20], [Static to Next Hop],
    [1], [Static to Interface],
    [1], [Connected],
    [0],
  ),
)

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

= Interior Gateway Protocols (IGP)

Establish the global connectivity between routers, within an AS.

#todo("Distance vector + BGP correlation")

#{
  let node = node.with(width: 6em, height: 3em)
  align(center, diagram(
    node((1.5, 0), [IGP], name: <igp>),
    node((.5, 1), [Distance\ Vector], name: <dv>),
    node((2.5, 1), [Link State], name: <ls>),
    node((0, 2), [RIP], name: <rip>),
    node((1, 2), [EIGRP], name: <eigrp>),
    node((2, 2), [OSPF], name: <ospf>),
    node((3, 2), [IS-IS], name: <isis>),
    edge(<igp>, <dv>),
    edge(<igp>, <ls>),
    edge(<dv>, <rip>),
    edge(<dv>, <eigrp>),
    edge(<ls>, <ospf>),
    edge(<ls>, <isis>),
  ))
}

== Open Shortest Path First (OSPF)

OSPF is an instance of a link state protocol designed for intra-domain routing in an IP network. OSPF gathers link state information from available routers and constructs a topology map of the network. The version of OSPF used in IPv4 networks is known as OSPF version 2 (OSPFv2). OSPF for IPv6 networks is known as OSPFv3.

=== SPF calculation

Every time there is a change in the network topology, OSPF needs to reevaluate its shortest path calculations.

- For each intra-area topology change, routers must rerun SPF.
- An inter-area topology change do not trigger the SPF recalculation.
  - The router determines the best paths for interarea routes based on the calculation of the best path towards the ABR.
  - The changes that are described in type 3 LSAs do not influence how the router reaches the ABR.
  - SPF recalculation is not needed.

=== Network hierarchy

OSPF provides the functionality to divide an intra-domain network into sub-domains (areas). Areas are identified through a 32-bit area field. Area ID 0 is the same as 0.0.0.0. Every intra-domain must have a core area with area ID 0 (backbone area). All other areas connected to the backbone area are referred to as low-level areas. The backbone area is in charge of summarizing the topology of one area to another area and vice versa.

=== Router classification

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

#let abr = router.with(detail: "ABR")
#let br = router.with(detail: "BR")
#let ir = router.with(detail: "IR")
#let dr = router.with(detail: "DR")
#let bdr = router.with(detail: "BDR")
#let drother = router.with(detail: text(size: .75em)[DROTHER])

#align(center, diagram(
  albl((1, 0), "Area 2", name: <a2>),
  node((0, 0), shape: ir, name: <r2>),
  acld(enclose: (<r2>, <a2>)),

  albl((6, 0), "Area 3", name: <a3>),
  node((5, 0), shape: ir, name: <r3>),
  acld(enclose: (<r3>, <a3>)),

  albl((7, 5.5), "Area 1", name: <a1>),
  node((6, 6), shape: router, name: <r11>),
  node((8, 6), shape: abr, name: <r12>),
  node((7, 7), shape: ir, name: <r13>),
  acld(enclose: (<r11>, <r12>, <r13>, <a1>)),

  albl(
    (8, 0),
    [Link to Another\ Autonomous\ System (AS)],
    width: 8em,
    height: 4em,
    name: <as>,
  ),
  edge(<r12>, <as>),

  albl((1, 6), [Area 0\ OSPF\ Backbone], name: <a0>, width: 6em),
  node((0, 5), shape: abr, name: <r01>),
  node((0, 7), shape: br, name: <r02>),
  node((2, 5), shape: abr, name: <r03>),
  node((2, 7), shape: abr, name: <r04>),
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

=== Network types

OSPF is designed to address four different types of networks:

_Point-to-point networks_ refer to connecting a pair of routers directly by an interface/link.

#align(center, diagram(
  spacing: (5em, 5em),
  node((0, 0), shape: router),
  edge(),
  node((2, 0), shape: router),
))

_Broadcast networks_ are multi-access where all routers in a broadcast network can receive a single transmitted packet. In such networks, a router is elected as a Designated Router (DR) and another as a Backup Designated Router (BDR).

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  diagram(
    node((1, 2), shape: drother, name: <r1>),
    node((3, 2), shape: dr, name: <r2>),
    node((5, 2), shape: bdr, name: <r3>),
    node((7, 2), shape: drother, name: <r4>),

    edge(<r1>, (1, 0)),
    edge(<r2>, (3, 0)),
    edge(<r3>, (5, 0)),
    edge(<r4>, (7, 0)),
    edge((0, 0), (8, 0)),
  ),
  diagram(
    node((0, 0), shape: dr, name: <r1>),
    node((2, 0), shape: bdr, name: <r2>),
    node((0, 2), shape: drother, name: <r3>),
    node((2, 2), shape: drother, name: <r4>),
    node((-1, 1), shape: drother, name: <r5>),
    node((3, 1), shape: drother, name: <r6>),

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
  node((0, 0), shape: dr, name: <r1>),
  node((2, 0), shape: bdr, name: <r2>),
  node((-1, 1), shape: drother, name: <r5>),
  node((3, 1), shape: drother, name: <r6>),

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

==== Optimization on Non-Point-to-Point Networks

- Designated Router (DR) and Backup Designated Router (BDR) based on priority or router ID
- DR performs the LSA forwarding and LSDB synchronization tasks on behalf of all routers on the broadcast domain
- Each router establishes a FULL adjacency with the DR and the BDR by using the IPv4 multicast address 224.0.0.6
- The BDR performs the DR tasks only if the DR fails.

=== Virtual links

- Virtual links cannot go through more than one area.
- Virtual links can only run through standard non-backbone areas. (not over stubby areas for example)

_OSPF Design Rule 1_: *Area 0 has to be contiguous.* For example, if a backbone is partitioned into two parts due to a link failure, virtual links are used. In such a case, virtual links are tunnelled through a non-backbone area

_OSPF Design Rule 2_: *A non-backbone area has to be connected to the backbone area.* Virtual links are used to connect an area to the backbone using a non-backbone (transit) area. Virtual links are configured between two Area Border Routers.


#{
  let albl = albl.with(height: 2em)
  table(
    columns: (1fr, 1fr),
    align: horizon + center,
    table-header([Rule 1], [Rule 2]),
    diagram(
      spacing: (2em, .5em),
      albl((0, 2), "Area 0", name: <a01>),
      acld(enclose: (<a01>,), inset: 3em),

      albl((0, 0), "Area 2", name: <a2>, inset: 2em),
      node(
        (0, 1),
        shape: abr,
        name: <r2>,
      ),
      acld(enclose: (<a2>,), inset: 3em),

      albl((2, 2), "Area 0", name: <a02>),
      acld(enclose: (<a02>,), inset: 3em),

      albl((2, 0), "Area 1", name: <a1>),
      node(
        (2, 1),
        shape: abr,
        name: <r1>,
      ),
      acld(enclose: (<a1>,), inset: 3em),

      albl((1, 4), "Area 3", name: <a3>),
      acld(enclose: (<a3>,), inset: 3em),

      node((0.5, 3), shape: router, name: <r3>),
      node((1.5, 3), shape: router, name: <r4>),

      albl(
        (1, 9),
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
      spacing: (2em, .5em),
      albl((0, 2), "Area 1", name: <a01>),
      acld(enclose: (<a01>,), inset: 3em),

      albl((1, 0), "Area 2", name: <a2>),
      node(
        (0.5, 1),
        shape: abr,
        name: <r2>,
      ),
      acld(enclose: (<a2>,), inset: 3em),

      albl((1, 4), "Area 0", name: <a3>),
      acld(enclose: (<a3>,), inset: 3em),

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
}

=== Passive Interfaces

The passive interface is used on interfaces where the router is not expected to form any OSPF neighbor adjacency. On a passive interface, the router stops sending and receiving OSPF Hello packets.

=== Link State Advertisement (LSA) Types

OSPF floods routing information such as link state advertisements. The scope of flooding of OSPF packets depends on the LSA types. The four most commonly known LSA types are:

#todo("Diagrams")

#deftbl(
  [Router LSA\ (Type Code=1)],
  [
    Every router generates a Router LSA that lists all the routers' outgoing interfaces. For each interface, the state and cost of the link are included. Such LSAs are generated for point-to-point links.

    - Type: All routers in Area
    - Scope: Flooding of Router LSAs is restricted to the area where they originate. (AREA)
  ],
  [Network LSA\ (Type Code=2)],
  [
    Network LSAs are applicable in broadcast and non-broadcast networks where they are generated by the DR. A Network LSA represents a LAN. All attached routers and the DR are listed in the Network LSA.

    - Type: Only DRs
    - Scope: Flooding of Network LSAs is also restricted to the area where they originate. (AREA)
  ],
  [Network Summary LSA\ (Type Code=3)],
  [
    Area Border Routers (ABR) generate Network Summary LSAs that are used for advertising destinations outside an area.

    - Type: Only ABRs
    - Scope: Flooded in all the areas that are not totally stubby. (AREA)
  ],
  [ASBR Summary LSA\ (Type Code=4)],
  [
    Identifies the ASBR and provides a route to the ASBR. All traffic that is destined to an external autonomous system requires routing table knowledge of the ASBR that originated the external routes. Subsequent ABRs regenerate a type 4 LSA to flood it into their areas. #todo("external bit + diagram")

    - Type: Only ABRs
    - Scope: (AREA)
  ],
  [AS External LSA\ (Type Code=5)],
  [
    AS External LSAs are generated by ASBRs and propagate the external networks within the OSPF domain. Destinations external to an OSPF AS are advertised using AS external LSAs.

    - Type: ASBR and ABR
    - Scope: AS external LSAs are flooded in all the areas that are neither stub nor totally stubby. (DOMAIN)
  ],
  [External LSA\ (Type Code=7)],
  [
    Also contain external networks within the OSPF domain. NSSA areas do not allow type 5 external LSAs #todo("link to areas")

    - Type: ASBRs
    - Scope: (AREA)
  ],
)

OSPF Accepted LSAs per Area Type

#align(center, table(
  columns: 7,
  table-header([], [LSA 1], [LSA 2], [LSA 3], [LSA 4], [LSA 5], [LSA 7]),
  emph[Backbone Area],
  cg,
  cg,
  cg,
  cg,
  cg,

  cr, emph[Non-Backbone Area], cg, cg, cg, cg, cg,
  cr, emph[Stub Area], cg, cg, cg, cr, cr,
  cr, emph[Totally Stubby Area], cg, cg, cr, cr, cr,
  cr, emph[Not-So-Stubby Area], cg, cg, cg, cr, cr,
  cg,
))

#todo("finish (slides 38)")
#diagram(
  spacing: (1em, 1em),
  node(
    (0, 0),
    [External Routing\ Domain],
    shape: cloud,
    width: 10em,
    height: 6em,
  ),
  node(enclose: ((1, -2), (3, -2), (1, 4), (3, 4)), inset: -1em, [Area 1]),
  node(
    enclose: ((3, -2), (5, -2), (3, 4), (5, 4)),
    inset: -1em,
    [Area 0 (Backbone)],
  ),
  node((1, 0), shape: router.with(detail: "R3"), name: <r3>),
  node((3, 0), shape: router.with(detail: "R2"), name: <r2>),
  node((5, 0), shape: router.with(detail: "R1"), name: <r1>),
  edge(<r3>, <r2>, "<->", label: [Type 1 or 2]),
  edge(<r2>, <r1>, "<->", label: [Type 1 or 2]),
  edge((2, 1), (3, 1), "<->", label: [Type 3]),
  edge((3, 2), (4, 2), "->", label: [Type 4]),
  edge((1, 3), (4, 3), "->", label: [Type 5]),
)

=== Route types

#deftbl(
  [Intra-area routes],
  [Are originated and learned in the same local area *(O)*],
  [Inter-area routes],
  [Originate in other areas and are inserted into the local area to which your router belongs *(O IA)*],
  [External routes],
  [*(O E1 or O E2)*],
)

=== Flooding

OSPF sits directly on top of IP in the _TCP/IP stack_ by using the IP protocol number *89*. OSPF packets use the *multicast destination MAC address 224.0.0.5*. OSPF is required to provide its own reliable mechanism, instead of being able to use a reliable transport protocol such as TCP. OSPF addresses reliable delivery of packets through use of either an implicit or explicit acknowledgment.
- An _implicit acknowledgment_ means that a duplicate of the LSA as an update is sent back to the router from which it received the update.
- An _explicit acknowledgment_ means that the receiving router sends a link state acknowledgment packet on receiving a link state update.
Since a router may not receive acknowledgment from its neighbor to whom it sent a link state update message, a router is required to track a link state retransmission list of outstanding updates.
- An *LSA is retransmitted*, always as unicast, on a periodic basis *until an acknowledgment is received*, or the adjacency is no longer available.
- A router *floods all its LSAs every 30 minutes*, regardless of whether the content of the LSA such as the metric value has changed. Hence, the Link State Database (LSDB) is always synchronized between all routers in an area

=== Packet format

#import fletcher.shapes: brace, diamond, ellipse, pill

#{
  let node = node.with(width: 7em)
  align(center, diagram(
    spacing: (7em, 3em),
    node((0.2, -.5), [LSA], shape: pill),
    edge("-|>"),
    node((1, -.5), [Entry in\ LSDB?], shape: diamond),
    edge("-|>", label: "Yes"),
    edge(<add>, "-|>", label: "No"),
    node((2, -.5), [Sequence nr different?], shape: diamond),
    edge("-|>", label: "No"),
    edge(<hi>, "-|>", label: "Yes"),
    node((2.9, -.5), [Ignore LSA]),
    edge(<end>, "-|>", corner: right),

    node((2, 1), [Sequence nr higher?], shape: diamond, name: <hi>),
    edge(<add>, "-|>", label: "Yes"),
    edge("-|>", label: "No"),

    node((2, 2), [Send LSU with newer information to source], width: 8em),
    edge(<end>, "-|>"),

    node((1, 1), [Add to LSDB], name: <add>),
    edge("-|>"),
    node((1, 1.75), [Send LSAck]),
    edge("-|>"),
    node((1, 2.5), [Flood LSA]),
    edge("-|>"),
    node((1, 3.25), [Run SPF and calculate new routing table], width: 8em),
    edge("-|>"),
    node((2, 3), [End], name: <end>, shape: pill),
  ))
}

OSPF has 5 packet types:

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  table-header([Packet Type], [Function], [Transmission Mode], [Address]),
  [Hello],
  [Discovery/Maintain],
  [Usually Multicast],

  [244.0.0.5\*], [DBD], [Database Summary], [Unicast],
  [Neighbor IP], [LSR], [Request LSA], [Unicast],
  [Neighbor IP], [LSU], [Link State Update], [Multicast/Unicast],
  [244.0.0.5/.6\* or Unicast], [LSAck], [Acknowledgement], [Multicast/Unicast],
  [244.0.0.5/.6\* or Unicast],
)
\* 244.0.0.5 for all routers, 244.0.0.6 for DR/BDR

==== Hello Packet (Hello)

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

==== Database Description Packet (DBD)

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

==== Link State Request Packet (LSR)

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

==== Link State Update Packet (LSU)

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

==== Link State Acknowledgement Packet (LSAck)

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

=== Sub-Protocols

==== Hello Protocol

During initialization/activation, the hello protocol is used for *neighbor discovery* as well as to *agree on several parameters* before two routers become neighbors.

- When using the hello protocol, *logical adjacencies are established* for point-to-point, point-to-multipoint, and virtual link networks.
- For broadcast and NBMA networks, not all routers become logically adjacent. The hello protocol is used for *electing Designated Routers and Backup Designated Routers*.

After initialization, for all network types the hello protocol is used for *keeping alive connectivity* which ensures bidirectional communication between neighbors. If the keep alive hello messages are not received within a certain time interval that was agreed upon during initialization, the link/connectivity between the routers is assumed to be not available.

==== Database Synchronization Protocol

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
      custom-image: cetz.canvas(length: 2em, {
        i-router()
      }),
    )
    _par(
      "b",
      display-name: [Router ID\ 10.1.1.254],
      shape: "custom",
      custom-image: cetz.canvas(length: 2em, {
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

=== Routing computation and Equal-Cost MultiPath

Default costs

#table(
  columns: (1fr, 1fr),
  table-header([Bandwidth (b/s)], [Cost]), [128K],
  [781], [10M],
  [10], [100M],
  [1],
)

LSAs type 1 and 2 are flooded throughout an area. This allows every router in an area to build link state databases with identical topological information.
- Shortest path computation based on Dijkstra’s algorithm is performed at each router for every known destination based on the directional graph determined from the link state database.
- The link cost used for each link is the metric value advertised in the link state advertisement packet. The value can be between 1 and 65 535
- Dijkstra-based shortest path computation using link state information is applied only within an area. For routing updates between areas, information from one area is summarized using Summary LSAs without providing detailed link information.
The next hop is extracted from the shortest path computation to update the routing table and
subsequently, the forwarding table.
- Routing table entries are for destinations identified through hosts or subnets or simply IP prefixes with CIDR notation, not in terms of end routers.
- Because of CIDR, multiple similar route entries are possible, eg. 10.1.64.0/24 vs 10.1.64.0/18. To select the route preferred by an arriving packet, OSPF uses a best route selection process (most specific match).
- In case there are multiple paths available after this step, the second step selects the route where an intra-area path is given preference over an inter-area path, which in turn gives preference over external paths for routes learned externally.

==== Equal-cost multipath (ECMP)

Equal-cost multipath (ECMP) means that if two paths have the same lowest cost, then the outgoing link (next hop) for both can be listed in the routing table so that traffic can be equally split. The original Dijkstra’s algorithm generates only one shortest path even if multiple shortest paths are available. To capture multiple shortest paths, where available, Dijkstra’s algorithm is slightly modified.

#todo("example diagram")

#todo("check this")

The router implementation handles the ECMP path selection on a per-flow basis rather than on a per-packet basis. The ECMP path selection is based on the hash of certain fields of the IP packet without having to maintain states at routers.

==== Stub areas and stub networks

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

==== Route selection

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

==== Route summarization

Route summarization helps solve two major challenges

- Large routing tables
- Frequent LSA flooding throughout the autonomous system

With route summarization, the ABRs or ASBRs consolidate multiple routes into a single advertisement

- Route summarization requires a good addressing plan
- Subnets in areas should be assigned contiguously to ensure that these addresses can be summarized into a minimal number of summary addresses

Summarization is only allowed on ASBRs and ABRs

#todo("ABR/ASBR (slide 50-53)")

=== Extending OSPF

- Classical OSPF is not easy to extend to add new features
  - They require the creation of a new LSA
  - OSPF version 2 was developed exclusively for IPv4
  - #rfc(7684) introduces Opaque LSAs

== Intermediate System to Intermediate System (IS-IS)

#todo("TLV: Type Length Value")

- Widely used (especially in ISP networks / as an intra-domain routing protocol)
- Fast convergence
- Equal Cost Multipath (ECMP) Load Balancing
- IS-IS supports different protocol suites #rfc(1195)
- Originally developed for ISO OSI environments (CLNS) but integrated IS-IS can be used to support pure-IP or dual environments. In modern IP-only environments:
  - There are no CLNP-based user applications.
  - The routing process is the primary user of the underlying CLNS mechanisms.
  - The only ISO packets typically observed are ES-IS and IS-IS control messages.
  - CLNP node-based addresses are still used to identify routers

#todo([
  definitions

  - End-host devices are called End Systems (ES)
  - Routers are called Intermediate Systems (IS)
  - IIH
])

=== Connectionless Network Service (CLNS)

Different to the TCP/IP suite, the OSI architecture has a strict distinction between services and
protocols. _Services_ are defined as the *functions provided by one layer to the layer above it*, while _protocols_ are the *specific implementations of these services* In the OSI model, each layer provides services to the layer above it and relies on services from the layer below it.

#table(
  columns: (auto, 1fr, auto),
  table-header([], [OSI Model], [TCP/IP Model]),
  [L3 Service],
  [CLNS (Connectionless Network Service)],

  [No separate name], [Service Type], [Connectionless],
  [Connectionless],
  [Data-Plane Protocol],
  [CLNP (Connectionless Network Protocol)],

  [IP (Internet Protocol)],

  [Control-Plane Protocol], [IS-IS / ES-IS], [OSPF / IS-IS / BGP / etc.],
  [Addressing], [NSAP (Network Service Access Point)], [IP Address],
)

==== Protocol Suite

The connectionless network service defined by CLNS (Connectionless Network Service) is realized and supported within the ISO architecture by several protocols, including:

- CLNP: the network-layer data protocol
- ES-IS: the host-to-router discovery protocol
- IS-IS: the router-to-router routing protocol

CLNP, ES-IS, and IS-IS are specified as separate network layer protocols, coexisting at Layer 3 of the OSI reference model.

==== Connectionless Network Protocol (CLNP)

The CLNP is the OSI equivalent of the IP.

- Both are connectionless.
- Both provide best-effort delivery.
- Both rely on separate routing protocols for path calculation.

CLNP operates at Layer 3 of the OSI model and provides connectionless, best-effort packet delivery between systems.

CLNP provides network-layer services to ISO transport protocols, rather than to TCP and UDP as in the TCP/IP architecture.

At the data-link layer, CLNP packets are identified by the Ethernet protocol type: #hex(65278).

==== End System to Intermediate System (ES-IS)

Operates between hosts (End Systems) and routers (Intermediate Systems) in an ISO CLNS environment. Its primary function is adjacency and reachability discovery within a shared network segment (for example, a LAN). ES-IS automates the exchange of addressing and presence information between connected systems.

The protocol operates using two message types:

- ESH (End System Hello) — transmitted by hosts
- ISH (Intermediate System Hello) — transmitted by routers

These messages allow systems to discover neighboring devices and their network layer addresses. From a functional perspective, ES-IS can be loosely compared to the combined roles of:

- ARP (address resolution)
- ICMP (reachability signaling)
- DHCP (host configuration assistance)

When IS-IS is configured on certain router platforms, ES-IS functionality operates automatically in the background to support adjacency formation.

#todo("diagram (prestudy 4)")

==== Intermediate System to Intermediate System (IS-IS)

IS-IS is a link-state routing protocol operating between routers (Intermediate Systems). Originally developed for routing CLNP traffic within ISO CLNS networks, IS-IS dynamically exchanges topology and reachability information between routers. It builds a link-state database and computes shortest paths using the SPF algorithm.

IS-IS operates in conjunction with ES-IS:

- ES-IS supports neighbor discovery.
- IS-IS establishes and maintains router adjacencies.
- IS-IS distributes routing information across the routing domain.

On multi-access networks, routers learn the data-link addresses (for example, MAC addresses, also referred to as SNPAs Subnetwork Points of Attachment) of adjacent systems and store this information in the adjacency database.

==== Network Service Access Point (NSAP)

An NSAP address identifies a network-layer entity within the OSI architecture. It is the CLNS equivalent of an IP address, although its structure differs significantly.

An NSAP address:

- Is variable in length (up to 20 bytes)
- Is hierarchically structured
- Identifies a system rather than a specific interface
- Is used by routing protocols such as IS-IS

#todo([
  frame

  AFI (Authority and Format Identifier): Indicates the format of the NSAP address and the authority that assigned it.

  IDI (Initial Domain Identifier): Variable length, identifies the administrative domain or organization responsible for the address.

  DFI (Domain Specific Part Format Identifier): Specifies the format of the domain-specific part of the address.

  DSP (Domain Specific Part): Variable length, contains the hierarchical structure of the address, which can include area identifiers and system identifiers.
])

=== Similarities between IS-IS and OSPF

#todo("prestudy 24")

- Standardized
- Link-state protocol
- Similar sync mechanism
- Use Dijkstra SPF algorithm
- Similar update/flooding process
- Quick convergence
- Areas - two-level hierarchy
  - L1/L2 in IS-IS
  - Backbone/Non-Backbone in OSPF

=== Advantages

- Detects a failure faster
- Simpler than OSPF
- Well-positioned for IPv6
- Scalability
  - Less "chatty"
  - TLVs instead of new LSPs
- Stability
  - IS-IS operates directly over the data link layer
    - No technical need for IP to establish adjacencies
    - Security: immune to remote IP-based attack vectors. packets are directly encapsulated over the data link and are not carried in IP packets or even CLNP packets. Therefore, to maliciously disrupt the IS-IS routing environment, an attacker has to be physically attached to a router in the IS-IS network
  - SPF calculations use NSAP System IDs
  - Multiple protocols supported, but treated as metadata attributes

ISIS considered to be more scalable and better suited for large and complex networks. OSPF might struggle with very large networks, especially in one single area.

- IS-IS: groups updates into one LSP
- OSPF: many small LSA updates

=== Addressing

#todo("network diagram (slides 20)")

$
  underbrace(49.0011., "Area ID (11)")underbrace(0000.0000.0003., "System ID (R3)")underbrace(00, "NSEL")
$

The following list consists of requirements and caveats that must be followed to define NSAP for IS-IS routing in general and particularly on Cisco routers:

- Each node in an IS-IS routing area must have a unique SysID.
- The SysID of all nodes in an IS-IS routing domain must be of the same length.
- The length of the SysID is 6 bytes (fixed) on Cisco routers.

You can use one of the LAN MAC addresses on a router as its SysID, essentially embedding a MAC address (a Layer 2 address) in the NSAP. Another popular way to define unique SysIDs is by padding a dotted-decimal loopback IP address with zeros to transform it into a 12-digit address, which can then be easily rearranged to represent a 6-byte SysID in hexadecimal, by regrouping the digits in fours and separating them with dots.

#exbox(```cisco
# Interface Loopback 0: IP address 192.168.1.24

Router(config)# router isis
Router(config-router)# net 49.0001.1921.6800.1024.00
```)

#todo("ISIS CLNS/NET addresses diagrams (slides 18)")

==== CLNS Address

- OSI CLNS (Connectionless Network Service) Address
- Differs significantly from the known IP Address format
- Network Service Access Point defines the service

==== Network Entity Title (NET)

- Identifies talking to the router itself (not to a specific application)
- NSAP address with an NSEL (NSAP Selector) of 0
- Included in LSP header
- Area part starts with 49
  - Authority and Format Identifier
  - Stands for private/local address
- System ID
  - Follows no specific format
    - Some use loopback 0 address
    - Some use counter
- N-Selector 00 identifies a network entity

=== PDU

Each PDU has two packet types, one for each level.

Each type of IS-IS packet is made up of:

- A header with the common fields shared by all IS-IS packets
- A number of optional variable-length fields containing specific routing-related information (Type, Length, and Value (TLV)) which has become a synonym for variable-length fields.

Enhancements to the original IS-IS protocol are normally achieved through the introduction of
new TLV fields. A key strength of the IS-IS protocol design lies in the ease of extension through
the introduction of new TLVs rather than new packet types.

==== Hello Packet (Hello)

Used to establish adjacencies between IS-IS neighbors. Once the neighbors are discovered, hello packets act as keepalive messages to maintain the adjacency. Additionally to the L1 and L2 types, Point-to-point hello packets exist.

#todo("")

+ discover
+ build
+ maintain

IS-IS neighbor adjacencies: Sent periodically
- Level 1 IIHs: Intra-Area adjacencies
- Level 2 IIHs: Inter-Area adjacencies

==== Link-State Packet (LSP)

- Primary container router and neighbor information
- Carries associated networks (IPv4/IPv6) as metadata TLVs
- Provides core data for building LSDB
- Sequenced to prevent duplication
- Unicast on Point-to-point Links, Multicast on broadcast media

==== Sequence number PDUs (SNPs)

Sequence number PDUs are used to ensure that neighboring routers have the same notion of what is the most recent LSP from each other router.

===== Complete Sequence Number PDU (CSNP)

Describe summary of LSPs in the LSDB. Similar to DBD in OSPF.

===== Partial Sequence Number PDU PSNP

Request and Acknowledge missing pieces. OSPF LSR und LSAck in once.

=== Adjacencies

#todo("shorten + prestudy 20")

An adjacency must be in an up state for a router to send or process received LSPs:

- A Level 1 adjacency is formed when the area addresses match unless configured otherwise.
- A Level 2 adjacency is formed alongside the Level 1 unless the router is configured to be Level 1-only.
- If no matching areas exist between the configuration of the local router and the area addresses information in the received hello, only a Level 2 adjacency is formed.
- If the transmitting router is configured for Level 2-only, the receiving router must be capable of forming a Level 2 adjacency. Otherwise, no adjacency forms.

When designing IS-IS networks, always remember that the backbone must be contiguous. In other words, a Level 1-only router should never be inserted between any two Level 2 routers (Level 2-only or Level 1-2).

==== Router types

#todo("diagram (slides 27,39) (prestudy 8,9,10)")

===== Level 1 router (L1)

- Knows the topology only of its own area
- All L1 routers have same LSPDB within area

L1 routers form adjacencies only with other L1 routers that belong to the same area.2. During the hello process, the routers verify that their Area IDs match. If the Area IDs differ, no L1 adjacency is established.

After adjacency establishment, L1 routers exchange Level-1 Link-State Packets (L1 LSPs). In order to exchange routing information, IS-IS uses LSPs (Link State Packet) which is similar to OSPF’s LSAs. These LSPs contain:

- Information about directly connected neighbors within the area
- Reachable IP prefixes within the area
- Associated metrics

Through reliable flooding, each L1 router distributes its LSPs to all other routers in the same area so that all L1 routers have a consistent view of the area topology.

Based on the synchronized L1 LSDB, each router independently runs the SPF algorithm to compute optimal paths to all destinations within the area.

===== Level 2 router (L2)

- Knows about other areas
- All L2 routers have same LSPDB

An L2 router operates at the inter-area level and is responsible for routing between different IS-IS areas.

After adjacency establishment, Level-2 routers exchange Level-2 Link-State Packets (L2 LSPs). These LSPs contain:

- Information about neighboring Level-2 routers
- Reachable prefixes from their attached areas
- Associated metrics

Through reliable flooding, all Level-2 routers build a synchronized Level-2 LSDB that represents the inter-area topology.

Based on the synchronized Level-2 LSDB, each router independently runs a separate Level-2 SPF calculation.

===== Level 1/Level 2 router (L1-L2)

- Has a Level 1 link-state database for intra-area routing and a Level 2 link-state database for interarea routing
- L1-L2 routers maintain a separate L1 and L2 LSPDB

A L1-L2 router operates simultaneously at both routing levels and acts as the border router between an area and the Level-2 backbone, enabling communication between different IS-IS areas.

The router participates independently in both flooding domains, Level-1 LSPs within its local area and Level-2 LSPs across the backbone.

A L1-L2 router also runs two independent SPF calculations for both areas.

#todo("slides 29,30,31")

==== Point-to-point

IS-IS adjacencies on point-to-point links are initialized by receipt of ISHs through the ES-IS protocol. This is followed by the exchange of point-to-point IIHs. In the default mode of operation, IIHs are padded to the MTU size of the outgoing interface. Routers match the size of IIHs received to their local MTUs to ensure that they can handle the largest possible packets from their neighbors before completing an adjacency.

- An unnecessary pseudonode LSP is not included in the LSPDB of all routers in that level.
- CSNPs are not continuously flooded into a segment
- CSNPs are sent only once during start
- LSPs to describe topology changes
- PSNP to acknowledge

#todo("slides 36")

==== Multiaccess

The process of building adjacencies is not triggered by receipt of ISHs. A router sends IIHs on broadcast interfaces as soon as the interface is enabled.

Routers include the MAC addresses of all neighbors on the LAN that they have received hellos from, allowing for a simple mechanism to confirm two-way communication.

- Two-way communication is confirmed when subsequent hellos received contain the receiving router's MAC address (SNPA) in an IS Neighbors TLV field.
- Otherwise, communication between the nodes is deemed one-way, and the adjacency stays at the initialized state.

The broadcast medium is modeled as a node, called the pseudonode. The pseudonode role is played by an elected DIS.

#todo("diagram (prestudy 16)")

Multicast Addresses:

- All L1 ISs: 01-80-C2-00-00-14
- All L2 ISs: 01-80-C2-00-00-15

===== DIS election

#todo("merge with below")

- Designated Intermediate System
- Similar to the DR in OSPF Protocol
- Responsibility
  - Creating and updating pseudonode LSPs
  - Flooding LSPs over the LAN
- L1 and L2 DIS may not be the same router
- Selection of the DIS
  - The highest priority. Configurable priority from 0 to 127.
  - Highest SNPA (Subnetwork Point of Attachment)
    - Highest MAC address of router’s interface
#todo([
  DIS preemption

  Preemption is enabled

  - A selected router is not guaranteed to remain the DIS.
  - Any adjacent intermediate system with a higher priority automatically takes over the DIS role.
    - IS-IS does not use a backup DIS
])

===== Pseudonodes

To minimize the complexity of managing multiple adjacencies on multiaccess media, such as LANs, while enforcing efficient LSP flooding to minimize bandwidth consumption, IS-IS models multiaccess links as nodes, referred to as pseudonodes.

As the name implies, this is a virtual node, whose role is played by an elected DIS for the LAN. Separate DISs are elected for Level 1 and Level 2 routing.

- Election of the DIS is based on the highest interface priority, with the highest SNPA address (MAC address) breaking ties.
- The default interface priority on Cisco routers is 64.

The responsibilities of LAN Level 1 and Level 2 DISs include the following:

- Generating pseudonode link-state packets to report links to all systems on the LAN.
- The default interface priority on Cisco routers is 64.
- Carrying out flooding over the LAN for the corresponding routing level

#todo("diagram (prestudy 18)")

Despite the critical role of the DIS in LSP flooding, no backup DIS is elected for either Level 1 or Level 2. If the current DIS fails, another router is immediately elected to play the role.

An elected router is not guaranteed to remain the DIS if a new router with a higher priority shows up on the LAN. Any eligible router at the time of connecting to the LAN immediately takes over the DIS role, assuming the pseudonode functionality.

==== Passive interfaces

#todo("slides 37")

=== Areas

- The IS-IS Backbone must be a contiguous chain of L2-capable routers (L2 or L1/L2)
  - All L2-capable routers constitute the backbone of this network
  - The backbone will span multiple areas with member routers in every area.
  - ISIS has no backbone area, but rather a backbone path

#todo("diargam slides 44")

==== Link-State packets flooding

#todo("slides 40")

==== Level 1 routing

- Level 1 routing is routing within an area
- Use closest L1-L2 router for outside communication
  - L1-L2 routers do not advertise L2 routes into the L1 area
  - Attached bit indicates router has connectivity to backbone
  - Default Route to the closest L1/L2 router
  - An IS-IS L1 area is equivalent to an OSPF totally stubby area.

==== Level 2 routing

- Level 2 routing is routing between different areas
  - L1-L2 routers inject L1 prefixes into the L2 topology.
    - Routes from the L1 level are advertised to the L2 topology populating the L1 topology metric into the L2 link-state packet (LSP) metric.

#todo("diagram attached bit (slides 43)")

=== Hello process

Routers periodically send hello packets to adjacent peers, every hello interval. On Cisco routers, the default value of the hello interval is:

- 10s for ordinary routers
- 3.3s for the DIS on a multi-access link

IS-IS uses the concept of hello multiplier to determine how many hello packets can be missed from an adjacent neighbor before declaring it "dead".

- The maximum time-lapse allowed between receipt of two consecutive hello packets received is referred to as the holdtime.
- The holdtime is defined as the product of the hello interval and the hello multiplier.

=== Operations

#todo("slides 34")

- Level 1 routers follow a default route to the closest Level 1-2 router.
- Level 2 routers flag connectivity to the backbone to Level 1 routers by setting the attached bit in their Level 1 LSP, which is flooded throughout the area.

==== Interface metrics

Narrow metric:

- 6-bit field (value between 1 and 63)
- IS-IS assigns a default metric of 10 to all interfaces regardless of the interface bandwidth
  - A 1-Mbps link uses the same path metric as a 10-Gbps link by default

Wide metric:

- 24-bit field
- It should be used for large networks
  - The narrow-style metric can accommodate only 64 metric values, which is typically insufficient in modern networks

==== Path selection route types

IS-IS best-path selection uses the following processing order, identifying the route with the lowest path metric for each stage

- Intra-area routes (L1)
  - Routes that are learned from another router within the same level and area address
- Inter-area routes (L2)
  - Routes that are learned from another L2 router that came from an L1 router or from an L2 router from a different area address

External routes are no longer treated as a separate category for path selection; they are integrated based on their redistribution level and metric.

#todo("illustrate suboptimal routing (slides 50)")

==== Route leaking

Even though the selected default router might be the closest in the area, it might not be the best exit out of the area when the overall cost to the destination is considered. There is a possibility of suboptimal path selection, which can be corrected by route-leaking.

- Route-leaking is a technique that redistributes the L2 level routes into the L1 level
- Route leaking uses a restrictive route map or route policy to control which routes are leaked
- Set the Up/Down bit to mark routes leaked from Level 2 to Level 1, preventing routing loops by ensuring they aren't readvertised back into the backbone.

#todo("illustrate (slides 51)")

==== IS-IS summarization

Because all routers within a level must maintain an identical copy of the LSPDB, summarization occurs when routers enter an IS-IS level, such as

- L1 routes entering the L2 backbone
- L2 routes leaking into the L1 backbone
- Redistribution of routes into an area

The default metric for the summary range is the smallest metric associated with any matching network prefix

You configure only the network that needs to have a different route and on the L1/L2 router that is the more optimal BR (not the default BR).

= Border Gateway Protocol (BGP)

#rfc(1654) defines the Border Gateway Protocol as an EGP standardized path-vector routing protocol that provides scalability, flexibility, and network stability.

BGP does not advertise incremental updates or refresh network advertisements like OSPF or ISIS would – it prefers stability within the network. A flapping link could potentially result in the re-computation for thousands of routes.

#deftbl(
  [BGP Neighbor/peer],
  [],
  [BGP speaker],
  [],
)

#todo("Route reflector")

== Comparison to IGP

#table(
  columns: (1fr, 1fr),
  table-header([IGP], [BGP]),
  [Neighbors typically discovered using multicast packets on the connected subnets],

  [Neighbor IP address is explicitly configured and may not be on common subnet],

  [Does not use TCP], [Uses a TCP connection between neighbors (port 179)],
  [Advertises prefix/length],
  [Advertises prefix/length, called Network Layer Reachability Information (NLRI)],

  [Advertises metric information],
  [Advertises a variety of path attributes (PA) that BGP uses instead of a metric to choose the best path],

  [Emphasis on fast convergence to the truly most efficient route],
  [Emphasis on scalability; might not always choose the most efficient route],

  [Link-state logic], [Path-vector logic],
)

== Public IP Address Assignment

#todo("")

#deftbl(
  [ICANN],
  [],
  [IANA],
  [],
  [IR],
  [],
  [RIR],
  [],
  [NIR],
  [],
  [LIR],
  [],
  [RIPE],
  [],
)

+ ICANN and IANA group public addresses by major geographic region.
+ IANA allocates those address ranges to Regional Internet Registries (RIR).
+ Each RIR further subdivides the address space by allocating public address ranges to National Internet Registries (NIR) or Local Internet Registries (LIR). (ISPs are typically LIRs.)
+ Each type of Internet Registry (IR) can assign a further subdivided range of addresses to the end-user organization to use.

== Internet Route Aggregation

#todo("summarize + visualize hierarchy")

Problem:
- Increasing Internet Routing Table
  - If there are many small routes in routing table
Idea/Solution/Mitigation:
- Route Summarization
  - Allocate consecutive addresses in a single route by geography and ISP

== Autonomous Systems (AS)

Network under same administrative domain using one or more IGPs. An IGP is not required within an AS, and iBGP could be used, however, it would not scale well. Routing and security policies are under the control of a service provider or of a company.

=== Autonomous System Numbers (ASN)

Organizations requiring connectivity to the internet must obtain an Autonomous System Number. They were originally 2 bytes with #dec(65535) ASNs. This limited range was exhausted rather quickly, prompting the expansion of the ASN range to 4 bytes in #rfc(4893), resulting in #dec(4294967295) ASNs, being backward compatibile with ASN 23456 (ASN_TRANS).

Two blocks of private ASNs are available to any organization. These can be used as long as the companies do not exchange them on the internet (similar to the private IPv4 addresses specified in #rfc(1918)). They are defined in #rfc(6996) (Autonomous System Reservation for Private Use):

- 16-bit range: #dec(64512) – #dec(65534)
- 32-bit range: #dec(4200000000) – #dec(4294967294)

Note that #rfc(7300) (Reservation of Last Autonomous System Numbers) define #dec(65535) (last 16-bit ASN) and #dec(4294967295) (last 32-bit ASN) as reserved, but not explicitly for private use.

== Sessions

A BGP session refers to the established adjacency between two BGP routers. BGP sessions are always *point-to-point* and are categorized into two types, iBGP and eBGP.

#todo("diagram (slides 40)")

=== Internal BGP (iBGP)

BGP that are peering within the same AS. iBGP sessions are considered more secure, and some of BGP’s security measures are lowered in comparison to eBGP sessions. iBGP prefixes are assigned an AD of 200 upon being installed into the router's RIB.

- AS-Path not modified
- Next-hop not modified

#todo("diagram (prestudy 12)")

The need for BGP within an AS typically occurs when transit connectivity is provided between autonomous systems.

Advertising the full BGP table into an IGP is not a viable solution for the following reasons:

- *Scalability*: In January 2024, the internet had 943 000+ IPv4 networks, and it’s still growing. IGPs do not scale to such a high number of routes.
- *Path Attributes*: IGP protocols do not know about BGP path attributes. Only BGP is capable of maintaining the path attribute as the prefix is advertised from one edge of the AS to the other edge.

==== Full Mesh Requirement

iBGP peers do not prepend their ASN to the AS_PATH because the NLRIs would fail the validity check (because it's the same ASN) and would not install the prefix into the IP routing table.

No other method exists to detect loops with iBGP sessions, and #rfc(4271) prohibits the advertising of NLRI received from an iBGP peer to another iBGP peer. It also states that all BGP routers within a single AS must be fully meshed to provide a complete loop-free routing table and prevent traffic _blackholing_.

#todo("prestudy 13")

==== Peering via Loopback Addresses

BGP sessions are sourced by the outbound interface toward the BGP peers IP address by default.

It is preferable to configure the BGP neighbours to establish a session between their loopback addresses. The loopback interface is virtual and always stays up. In the event of link failure, the session remains intact if the IGP finds another path to the loopback address.

==== Scalability

The inability for BGP to advertise a prefix learned from one iBGP peer to another can lead to scalability issues within an AS: Let $n$ be the number of iBGP speakers. There are $(n(n−1))/2$ sessions required. In asymptotic notation, we would categorize this as $O(n^2)$.

===== Route Reflectors

#todo("shorten (prestudy 16)")

#rfc(1966) introduces the concept of route reflection, which allows an iBGP speaker to advertise
routes learned from one iBGP peer to other iBGP peers. The router performing this function is
called a route reflector (RR).

An RR forms iBGP sessions with two types of peers:

- Client peers: iBGP peers configured as clients of the RR. The RR reflects routes between these peers.
- Non-client peers: regular iBGP peers of the RR that are not configured as clients. These peers behave like normal iBGP speakers and are expected to maintain a full mesh among themselves.

The following rules govern route reflection:

+ If a RR receives a NLRI from a non-client peer, the RR advertises the NLRI to all clients. It does not advertise the NLRI to other non-client peers.
+ If a RR receives a NLRI from a client, the RR advertises the NLRI to all non-client peers and to all other clients (except the originating client).
+ If a RR receives a NLRI from an eBGP peer, the RR advertises the NLRI to all clients and all non-client peers, subject to normal BGP rules.

Only route reflectors need to be aware of this modified advertisement behaviour. Route-reflector clients require no special configuration beyond establishing the iBGP session with the RR. By introducing route reflectors, the requirement for a full iBGP mesh can be relaxed: each client only needs to peer with the RR to receive the routes from the rest of the AS.

#todo[Loop prevention in iBGP]

=== External BGP (eBGP)

Sessions established with eBGP routers that are in different ASes. eBGP prefixes are assigned an AD of 20 upon being installed into the router's RIB.

- Each eBGP device modifies the AS-Path attribute with its own AS.
- Each eBGP device modifies the next-hop attribute

==== Comparison to iBGP

- Time to Live (TTL) on BGP packets is set to one by default. BGP packets drop in transit if a multihop BGP session is attempted.
- The advertising router modifies the BGP next-hop to the IP address sourcing the BGP connection.
- The advertising router prepends its ASN to the existing AS_PATH. The receiving router verifies that the AS_PATH does not contain an ASN that matches the local routers. BGP discards the NLRI if it fails the AS_PATH loop prevention check.

=== Combining iBGP and eBGP

Combining eBGP sessions with iBGP sessions can cause problems. The most common issue involves the failure of the next-hop accessibility. iBGP peers do not modify the next-hop address if the NLRI has a next-hop address other than 0.0.0.0.

The next-hop address must be resolvable in the global RIB for it to be valid and advertised to other BGP peers.

#todo("prestudy 15")

==== Next hop behavior

When paired with an eBGP neighbor the next‐hop is passed to the iBGP neighbor but the iBGP neighbor is not able to reach the next-hop.

To avoid the issue described in the previous section, the next-hop IP address can be modified. NHOP is a BGP attribute that can also be manipulated. Configuring the _next-hop-self_ feature modifies the next-hop address in all external NLRIs using the IP address of the BGP neighbour.

#todo[
  - The next-hop default behaviour can be modified on the iBGP peering with the feature next-hop-self
  - The link between AS 3303 and AS 40001 can be redistributed into the IGP.

  slides 43
]

=== Multihop Sessions

TCP allows for handling of fragmentation, sequencing, and reliability (acknowledgement and retransmission) of communication packets. While BGP can form neighbour adjacencies that are directly connected, it can also form adjacencies that are multiple hops away. Multihop sessions require that the routers use an underlying route installed in the RIB (static or from any routing protocol) to establish the TCP session with the remote endpoint.

#align(center, diagram(
  spacing: (4em, 1em),
  node(
    enclose: ((3, -1), (5, -1)),
    [R3 is unaware of the BGP session running through it],
  ),
  node((0, 0), shape: router.with(detail: [R1])),
  edge(label: [10.2.12.0/24], label-side: left),
  node((2, 0), shape: router.with(detail: [R2])),
  edge(label: [10.2.23.0/24], label-side: left),
  node((4, 0), shape: router.with(detail: [R3])),
  edge(label: [10.2.34.0/24], label-side: left),
  node((6, 0), shape: router.with(detail: [R4])),
  edge((0, 1), (1.8, 1), "<|-|>", label: [BGP peering], label-side: right),
  edge((2.2, 1), (6, 1), "<|-|>", label: [BGP peering], label-side: right),
  node(
    enclose: ((0, 3), (1.8, 3)),
    [R1 is able to establish a direct BGP session with R2 using the ARP table to locate the L2 address of the other peer.],
    inset: 0.5em,
    height: 8em,
  ),
  node(
    enclose: ((2.2, 3), (6, 3)),
    [R2 requires IP connectivity with R4 before being able to establish a BGP session. Multihop BGP sessions use the route table to find the IP address of the other peer, usually provided by a static route or IGP between iBGP neighbors.],
    inset: 0.5em,
    height: 8em,
  ),
))

== Messages

BGP utilizes 4 different types of messages to establish, maintain and tear down BGP peers: OPEN, KEEPALIVE, UPDATE and NOTIFICATION.

=== OPEN

The OPEN message is used to establish a BGP adjacency. It contains the BGP version number, ASN of the originating router, hold time, the BGP identifier, and other optional parameters that describe the session capabilities.

#table(
  columns: (1fr, 1fr),
  table-header([Hold Time], [BGP Identifier]),
  [
    Defines how many seconds to wait before declaring a BGP neighbour unreachable. Upon receiving an UPDATE or KEEPALIVE, the hold timer resets to the initial value. If the hold timer for a neighbour reaches zero, the BGP session to it is torn down: Routes from the timed-out neighbour are removed, and an appropriate route withdraw message is sent to other neighbours. When establishing a BGP session, both routers propose a hold time in their OPEN message, where the smaller value is chosen. For Cisco routers, the default hold time is 180s.
  ],

  [
    The BGP Router ID (RID, or simply BGP Identifier) is a unique 32-bit number that identifies the BGP process on that router. It can be used as a loop prevention mechanism for routers advertised within an autonomous system. It can be set manually or is assigned dynamically.

    Router IDs typically represent an IPv4 address that resides on the router, such as a loopback address. Any valid IPv4 address can be used, including ones not configured on the router. Configuring a static BGP RID is considered a best practice, as it provides consistency and stability.
  ],
)

=== KEEPALIVE

A BGP process does not rely on the TCP connection state to ensure that its neighbours are still alive. KEEPALIVE messages are exchanged every third of the hold timer agreed upon between the two BGP routers. Cisco devices have a default hold time of 180 s, so the default KEEPALIVE interval is 60 s.

=== NOTIFICATION

A NOTIFICATION message is sent when an error is detected with the BGP session, such as a hold timer expiring, neighbour capabilities change, or when a BGP session reset is requested. It causes the BGP connection to close.

=== UPDATE

An UPDATE message advertises feasible routes, withdraws previously advertised routes, or does both. It contains Network Layer Reachability Information (NLRI), which includes the prefix, along with associated BGP path attributes when advertising those prefixes. Withdrawn NLRIs include only the prefix. An UPDATE message can also act as a KEEPALIVE message to reduce obsolete traffic.

- Used to transfer routing information between peers.
- Includes new routes, removed routes and path attributes.

A BGP update message is composed of:

- A list of routes to explicitly *withdraw*.
- The *attributes* associated with the new prefixes being advertised in this update.
  - The attributes include AS path, MED, community, and many others.
- The new *prefixes*
  - The routes include both a network and a mask.

== Path Attributes

- Per #rfc(4271), *well-known* attributes must be recognized by all BGP implementations.
- *Optional* attributes do not have to be recognized by all BGP implementations.

BGP attributes can be classified in 4 categories:

- *Well‐known mandatory* attributes must be included with every BGP update.
- *Well‐known discretionary* attributes are not required in every BGP update.
- *Optional transitive* attributes stay with the route advertisement from AS to AS
- *Optional non‐transitive* attributes should be removed if not understood and should not be forwarded to other ASs

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  table-header(
    [Well‐known Mandatory],
    [Well‐known Discretionary],
    [Optional Transitive],
    [Optional Non-transitive],
  ),

  [
    - AS Path
    - Origin
    - Next Hop
  ],
  [
    - Atomic Aggregate
    - Local Preference
  ],
  [
    - Community
    - Aggregator
  ],
  [
    - MED
    - Weight
    - Cluster ID
    - Originator ID
    - Cluster List
  ],
)

NLRI (Network Layer Reachability Information) is the format used to represent the prefixes a BGP speaker advertises to its peers (informing them of networks reachable via specific paths). It consists of a network prefix, prefix length, and any BGP prefix attributes for that specific route.

== Path Calculation

A route advertisement consists of the NLRI and its path attributes. A BGP router may learn multiple paths to the same destination network. The attributes associated with each path influence the desirability of the route when the router selects the best path. A BGP router advertises only its selected best path to its peers.

Within the BGP table, all learned routes and their associated path attributes are maintained, and the best path is calculated. The selected best path is then installed in the router's routing table (RIB). If the best path becomes unavailable, the router can evaluate the remaining known paths to quickly select a new best path.

BGP recalculates the best path for a prefix when one of the following events occurs:

- A change in reachability of the BGP next hop.
- Failure of an interface connected to an eBGP peer.
- A change in redistributed routes.
- When receiving new paths for the same prefix.

Some router configurations modify the BGP attributes to influence inbound traffic or outbound traffic. BGP path attributes can be modified upon receipt or advertisement to influence routing in the local AS or neighbouring AS. A basic rule for traffic engineering with BGP is that modifications in outbound routing policies influence inbound traffic, and modifications to inbound routing policies influence outbound traffic.

=== Route Selection

BGP installs the first received path as the best path automatically. When additional paths are received, the newer paths are compared against the current best path. If there is a tie, then processing continues onto the next step, until the best path winner is identified.

BGP uses 11 steps to determine the best path:

+ Prefer highest weight (local to router) #corr("CISCO specific - do not use!")
+ Prefer highest local preference (global within AS)
+ Prefer routes that the router originated
+ Prefer shorter AS paths (only length is compared)
+ Prefer lowest origin code (IGP < EGP < Incomplete)
+ Prefer lowest MED (also called metric)
+ Prefer external (EBGP) paths over internal (IBGP)
+ For IBGP paths, prefer path through closest IGP neighbor
+ For EBGP paths, prefer oldest (most stable) path
+ Prefer paths from router with the lower BGP router-ID
+ Prefer the path that comes from the lowest neighbor address

#todo("diagram (slides 29-39)")

== Loop prevention

As a path-vector routing protocol, BGP does not contain a complete topology of a network (as opposed to link-state routing protocols). BGP behaves similar to distance vector protocols to ensure a path is loop free.

The BGP attribute _AS_PATH_ is a well-known mandatory attribute that includes a complete listing of all the ASNs that the prefix advertisement has traversed from its source AS. If AS-Path includes the router's ASN, then it is ignored.

== Network statements

#todo("shorten")

BGP Network statements identify a specific network prefix to be installed into the BGP table. After configuring a BGP network statement, the BGP process searches the global RIB for an exact network prefix match. The network prefix can be a connected network, secondary connected network, or any route from a routing protocol. After verifying that the network statement matches a prefix in the global RIB, the prefix is installed into the BGP table. The following BGP Origin path attribute is set depending on the RIB prefix type:

- Connected Network:  The next-hop BGP attribute is set to 0.0.0.0, the origin attribute is set to i (IGP), and for Cisco devices, the BGP weight is set to 32 768
- Static Route or Routing Protocol: The next-hop BGP attribute is set to the next-hop IP address in the RIB, the origin attribute is set to i (IGP), the BGP weight is set to 32 768 and the MED is set to the IGP metric.

== Route filtering and manipulation

#todo("shorten")

Route filtering is a method to select routes to receive from (import) or advertise to (export) neighbouring routers. This feature can be used to manipulate traffic flows, reduce memory utilization, or to improve security.

It is common for ISPs to deploy route filters on BGP peerings to customers: They want to ensure that only the customer’s routes are allowed over the peering link, preventing the customer from accidentally becoming a transit AS on the internet.

Filtering of routes within BGP is accomplished with _filter-lists_, _prefix-lists_, or _route-maps_ on Cisco IOS.

In Cisco IOS, regular expressions can be used in show commands and AS path accesslists to match BGP prefixes based on the information contained in their AS path.

=== Path Announcement

ASs announce paths to destination addresses, data flows back to the opposite direction.

#todo("better explanation/diagram?")

== Communities

BGP communities provide additional capability for tagging routes and for modifying BGP routing policy on upstream and downstream routers.

Communities can be appended, removed, or modified selectively on each attribute as the route travels from router to router. They are an optional transitive BGP attribute that can traverse from autonomous system to autonomous system. A BGP community is a 32-bit number that can be included with a route. It can be displayed as a full 32-bit number (0 −4 294 967 295 ) or as two 16-bit numbers (0 −65 535 ):(0 −65 535 ), commonly referred to as new-format.

= The Internet

== Structure

The internet is a network of networks.

- Internet is an interconnection of 10'000s autonomous service providers and customers.
- There is no central co-ordination for the management of interconnections, services and tariffs.

Who controls the internet?

- The control over paths is completely distributed. It is all based on trust.

#todo("diagram (slides 48)")

Assumption:

- The Internet was based on a well-ordered provider client hierarchy.

Reality:

- Unordered subset of interconnects
- Driven by business requirements underpinned by performance
- Non-disclosure and bilateral agreements
- Peering is now considered a corporate asset & legal concern

== Peering vs. Transit

The nature of the linking between these ISPs is governed by a series of agreements known as peering arrangements.

#deftbl(
  [Transit],
  [
    Business relationship where one ISP provides reachability to all destinations in it’s routing table to its customers.

    - Transit fees, usually paid by a smaller ISP to a larger
  ],
  [Peering],
  [
    Business relationship where ISPs provide to each other reachability to each pre-defined portions of their routing table

    - Peers are equals and pass traffic from one to another without worrying about payments.
    - They treat smaller ISPs as just another customer.
  ],
)

#todo("diagram (slides 50)")

== Routing Policies

- Each ISP has a unified routing policy framework
  - This is a vast and complex topic
- The decision on which routes to advertise and which routes to accept is determined by routing policy.
  - Routes, or prefixes, not only need to be advertised to another AS, but need to be accepted.
  - How should one ISP compensate another ISP for delivering packets that originate on the other ISP?
#todo("diagram (slides 52)")
- ISPs do not provide free transit services and generally are either peers or customers of other ISPs.
  - Unless “arrangements” are made, ISP B will routinely block transit traffic between ISP A and ISP C
#todo("diagram (slides 53)")

== Internet Exchange Point (IXP)

#todo("diagram (slides 56)")

#table(
  columns: (1fr, 1fr),
  table-header([Public IXP], [Private IXP]),
  [
    Member will generally peer with a route server.

    - Generally, over a common switched infrastructure

    The route server announces the members routes to all peers

    - Generally, the Route Server (RS) will inject its AS into the AS_PATH
    - The NEXT_HOP is preserved and keeps the RS out of the data path

    Lack of policy control

    - Single legal contract to manage
  ],

  [
    Members will peer on a one-to-one basis

    - Generally, over a common switched infrastructure - Public peering
    - Can be over private interconnects – Private peering

    Peers implement policy towards each other

    - One BGP session per neighbour
    - Multiple legal contracts to manage
  ],
)

== Connectivity options

#todo[slides 16-...]

=== Single-Homed without BGP

- The customer doesn't use BGP.
- Static default route on the customer side to reach outside networks
- Specific static route on the ISP side to reach the customer IP address prefix

=== Single-Homed with BGP

- The customer uses BGP
- Changes in the customer topology will then be sent to the provider.
- Provider may redistribute the changes to the internet.

=== Dual-Homed

- One or two customer router(s)
- Customer optimally runs BGP between routers
- ISP announces default route
- Usually used in a primary/backup design
  - Local Preference to steer traffic
  - First Hop Redundancy Protocols used to ensure correct traffic routing
    - e.g. Hot Standby Router Protocol (HSRP)
- Load-Sharing possible

Highest Local Preference used to influence how traffic is leaving the local network. (highest wins)

MED (Multi-Exit Discriminator) used to influence how traffic is entering the local network. (lowest wins)

AS-path prepending influences how traffic enters local network, by e.g. adding AS several times on backup path. (shortest path wins)

An AS has direct control over egress traffic but lacks absolute control over ingress paths. ISP’s Local Preference settings will take over, and effectively ignore, any MED or AS_PATH attributes.

=== Multi-Homed

Used in an active/active design

- By receiving the full routing table, the path through the internet can be optimized

A customer AS never wants to be transit

- Only advertise routes originating in own AS to ISPs

=== Aggregate

#todo("slides 35")

== Routing Security

- Internet Routing Registry (IRR)
  - unreliable

=== Resource Public Key Infrastructure (RPKI)

#rfc(6480)

A robust security framework for verifying the association between resource holder and Internet resource. Helps to secure Internet routing by validating routes

- Prevents route hijacking
  - A prefix originated by an AS without authorization with malicious intent
- Prevents route leakage
  - A prefix that is mistakenly originated by an AS which does not own it

"Is this AS number (ASN) authorized to announce this IP range?"

- RPKI-capable routers can fetch the validated Resource Origin Authorizations (ROA) data set from a validated cache

#table(
  columns: 3,
  [VALID], [INVALID], [NOT FOUND / UNKOWN],
  [Indicates that the prefix and ASN pair have been
    found in the database],
  [Indicates that the prefix is found, but:
    - ASN received did not match
    - The prefix length is longer than the maximum length
  ],
  [Indicates that the prefix does not match any in
    the database],
)

==== Trust Anchors

- Trust anchor (TA) is a certificate authority (CA) in RPKI terms
- The five Regional Internet Registries (RIR) are the TAs
- The TAs have these responsibilities:
  + Provide the infrastructure so that resource holders can sign their prefixes and ASNs.
  + Provide a public list so that others can verify these prefixes and ASNs.

#todo[X.509 Certificate with RFC3779 Extension (slides 53)]

==== Route Origin Authorization (ROA)

- A signed digital object that contains a list of addresses, prefixes and one AS number
- Created by a prefix holder to authorize an AS number to originate one or more specific route advertisements
- An ROA is valid if, the associated certificate can be validated up to the TA of the of the corresponding RIR e.g. (RIPE, APNIC, etc.)

==== RPKI Validators

- RPKI Validators also called Relying Party Software
- Run independently by an organization
- Synchronizes and validates resource records
- Preloaded with trust anchor locators (TALs) for all RIRs.
- Retrieves data with a specific protocol #rfc(8182)
  - Follows chain of trust top to bottom
- Validates cryptographic signatures on all objects.
  - Outputs a list of Validated ROA Payloads (VRPs).
- Periodically retrieves updates

Currently, RPKI only provides origin validation. While BGPsec path validation is a desirable characteristic and standardised in #rfc(8205), real-world deployment may prove limited for the foreseeable future. However, RPKI origin validation functionality addresses a large portion of the problem surface.
