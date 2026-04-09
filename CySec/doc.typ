#import "../lib.typ": *
#import "./info.typ": info

#show: project.with(..info)
#let (
  add-note,
  add-answer-note,
  add-hd-note,
  deftbl,
  defbox,
  exbox,
) = tanki-utils(gen-id(info.module))

= Information security

#deftbl(
  [Information],
  [An organization's data that has been processed, organized, or structured in a
    way that gives it meaning and value to an organization or individual.],
  [Information security],
  [Protection of the integrity, confidentiality and availability of information
    data whether in storage, transit or processing.],
  [non-repudiation],
  [prevents parties from denying actions they have performed.],
  [accountability],
  [ability to trace actions and decisions back to a specific person or system.],
  [authentication],
  [verifies the identity of a user or system.],
  [authorization <authorization>],
  [determines what actions an authenticated entity is allowed to perform.],
  [access control],
  [restricts access to resources based on defined rules.],
  [business continuity],
  [ensures critical operations continue during disruptions.],
  [security policy],
  [a rule or expectation for protecting information.],
  [compliance],
  [adherence to laws, regulations, and (security-)standards.],
  [asset],
  [
    any item of value belonging to an organization
    - For example: information, systems, people and processes
  ],
  [attack],
  [an act that intends to damage, steal or degrade an organizations assets],
  [vulnerability],
  [a flaw or weakness in a system that can be abused],
  [exploit],
  [a technique or method used to take advantage of a vulnerability],
  [threat],
  [an event or action with the potential to cause harm by exploiting a
    vulnerability],
  [risk],
  [the likelihood of a threat exploiting a vulnerability and the potential harm
    that could cause],
  [control],
  [
    a measure designed to reduce the potential risk of an attack
    - Can be achieved through training employees, enforcing policies or
      implementing technology
  ],
)

#align(center, cetz.canvas({
  import cetz.draw: *
  circle((0, 0), radius: (4, 2))
  content((-2, 0), [Cybersecurity])
  circle((2, 0), radius: 1.25)
  content((2, 0), [IT-Security])
  circle((4, 0), radius: (4, 2))
  content((6, 0), [Information\ Security])
}))

#start-note()
== Types of information

#start-field()
- Personal information
- Business information
- Financial information
- Intellectual property
  - Copyright
  - Trademarks
  - Patents
  - Trade secrets
- System information
#end-note()

#start-note()
== How can information be attacked

#start-field()
- In storage
  - Data that is stored on a server or in a database short-term or long-term.
- In transit
  - Data that is currently being transported from one place to another.
- In use
  - Data that is currently being processed by a service or another entity.
#end-note()

#start-note()
== Components of an Information System (IS)

#start-field()
- Software
- Hardware
- Data
- People
- Procedures
- Networks
#end-note()

#start-note()
== Balancing security and system usability

#start-field()
- Obtaining perfect information security is impossible.
- Security needs to protect the system without slowing people down.
- Too much security can lead to workarounds.
  - Example: If strong passwords are enforced, people might start writing them
    down on sticky notes.
- Too much convenience exposes the system to unnecessary risks.
- It's all about finding that sweet spot between security and usability.
  - Example Solution: Employees must use multi-factor authentication. This way,
    they are free to use a less secure password without compromising the overall
    security.
- An even better, continuously review policies and involve users to find the
  best solution.
#end-note()

#start-note()
== Implementation of information security

#start-field()
#align(center, diagram(
  // node-fill: colors.bg,
  // node((0, 0), shape: (node, extrude, ..) => cetz.draw.line(
  //   (0, 1),
  //   (-5, -7),
  //   (5, -7),
  //   close: true,
  // )),
  node((-1.75, -1), "Top-down approach"),
  edge((-1.75, 5.5), "->", stroke: 2pt),
  node((1.75, -1), "Bottom-up approach"),
  edge((1.75, 5.5), "<-", stroke: 2pt),

  node((0, 0), "CEO", name: <ceo>),

  edge(<ceo>, <cfo>),
  edge(<ceo>, <cio>),
  edge(<ceo>, <coo>),

  node((-1, 1), "CFO", name: <cfo>),
  node((0, 1), "CIO", name: <cio>),
  node((1, 1), "COO", name: <coo>),

  edge(<cio>, <ciso>),
  edge(<cio>, <vp-sys>),
  edge(<cio>, <vp-net>),

  node((-1, 2), "CISO", name: <ciso>),
  node((0, 2), "VP-Systems", name: <vp-sys>),
  node((1, 2), "VP-Networks", name: <vp-net>),

  edge(<ciso>, <security-mgr>),
  edge(<vp-sys>, <systems-mgr>),
  edge(<vp-net>, <network-mgr>),

  node((-1, 3), [security\ mgr], name: <security-mgr>),
  node((0, 3), [systems\ mgr], name: <systems-mgr>),
  node((1, 3), [network\ mgr], name: <network-mgr>),

  edge(<security-mgr>, <security-admin>),
  edge(<systems-mgr>, <systems-admin>),
  edge(<network-mgr>, <network-admin>),

  node((-1, 4), [security\ admin], name: <security-admin>),
  node((0, 4), [systems\ admin], name: <systems-admin>),
  node((1, 4), [network\ admin], name: <network-admin>),

  edge(<security-admin>, <security-tech>),
  edge(<systems-admin>, <systems-tech>),
  edge(<network-admin>, <network-tech>),

  node((-1, 5), [security\ tech], name: <security-tech>),
  node((0, 5), [systems\ tech], name: <systems-tech>),
  node((1, 5), [network\ tech], name: <network-tech>),
))
#table(
  columns: (1fr, 1fr),
  table-header([Bottom-Up], [Top-Down]),
  [
    - Initiated by an organization’s technical staff (system engineers, admins,
      etc.).
    - Implementations happen before policies are defined.
    - Often lacks support from management, budget and consistency.
    - Generally less effective and not scalable in large organizations.
  ],

  [
    - Initiated and supported by an organization’s upper management.
    - Policies come first and provide guidance for implementations.
    - Ensures proper funding, authority and organization-wide enforcement.
    - Generally more effective and in-line with the business strategy
  ],
)
#end-note()

#add-hd-note("CIA Triad", [
  The CIA triad is a foundational information-security model stating that
  systems should protect:
  - *Confidentiality* - Keeping information secret <confidentiality>
  - *Integrity* - Keeping information correct and unaltered <integrity>
  - *Availability* - Ensuring information and systems remain
    accessible <availability>

  #table(
    columns: (auto, 1fr, 1fr, 1fr),
    table-header([], [Confidentiality], [Integrity], [Availability]),
    [Goal],
    [Prevent or minimize unauthorized access to information],
    [Protecting the reliability and correctness of information.],

    [Ensuring that subjects have timely and uninterrupted access to
      information.],

    [Steps to\ ensure it],
    [
      - Encryption
      - Access Control
      - Allow / enforce advanced authentication mechanisms
    ],
    [
      - Digital Signatures
      - Hashing and Checksums
      - Change Management
    ],
    [
      - Redundance and Backups
      - DDoS Protection
      - Incident Response
    ],
  )
])

#start-note()
== Non-Repudiation and Accountability

#start-field()
Example of security controls through which non-repudiation can be established:
Digital certificates, session identifiers, transaction logs, etc.
#end-note()

#add-hd-note(n: 3, "Non-Repudiation", [
  - Ensures that the subject of an activity or who caused an event cannot deny
    having performed an action or cannot deny that the event occurred.
  - Non-Repudiation prevents a subject from claiming not to have sent a message,
    not to have performed an action, or not to have been the cause of an event.
]) <non-repudiation>

#start-note()
=== Accountability

#start-field()
- Being responsible or obligated for actions and results.
- Non-Repudiation is an essential part of accountability. A suspect cannot be
  held accountable if they can repudiate the claim against them.
#end-note()

#start-note()
== STRIDE Model

#start-field()
A structured model developed by Microsoft used in cybersecurity to identify and
categorize threats to systems by looking at how they can be attacked.
#end-note()

#todo("Authenticity")
#deftbl(
  [S(poofing)],
  [Pretending to be someone else. (see #link(
      <confidentiality>,
      "Authenticity",
    ))],
  [T(ampering)],
  [Unauthorized data modification or altering. (see #link(
      <integrity>,
      "Integrity",
    ))],
  [R(epudiation)],
  [Denying actions without proof. (see #link(
      <non-repudiation>,
      "Non-Repudiation",
    ))],
  [I(nformation disclosure)],
  [Exposing sensitive information. (see #link(
      <confidentiality>,
      "Confidentiality",
    ))],
  [D(enial of service)],
  [Making systems or services unavailable. (see #link(
      <availability>,
      "Availability",
    ))],
  [E(levation of privilege)],
  [Gaining unauthorized rights or
    privileges./* FIXME: wtf (see #link(<authorization>, "Authorization"))*/],
)

#start-note()
== McCumber Cube

#start-field()
#grid(
  columns: 2,
  [
    #tr([Y-Axis: Security Goals (C.I.A. Triad)])

    - Defines what needs to be protected.

    #td([X-Axis: Information States])

    - Describes where the information exists.

    #tg([Z-Axis: Safeguards / Controls])

    - Defines how protection is implemented.
  ],
  // mmh yes hackiness
  rotate(20deg, pad(top: -1.5em, bottom: 2em, cetz.canvas({
    import cetz.draw: content, grid, group, set-origin
    content((-.5, 0), (-3, 1), align(right + horizon, tr[Availability]))
    content((-.5, 1), (-3, 2), align(right + horizon, tr[Integrity]))
    content((-.5, 2), (-3, 3), align(right + horizon, tr[Confidentiality]))
    grid(
      (0, 0),
      (3, 3),
    )
    group({
      set-origin((3, 0))
      cetz.draw.rotate(y: 90deg)
      content((0, 3), (1, 3), place(dx: -13em, dy: -0.5em, block(
        width: 6em,
        align(right + horizon, tg[Policy]),
      )))
      content((1, 3), (2, 3), place(dx: -13em, dy: -0.5em, block(
        width: 6em,
        align(right + horizon, tg[Education]),
      )))
      content((2, 3), (3, 3), place(dx: -13em, dy: -0.5em, block(
        width: 6em,
        align(right + horizon, tg[Technology]),
      )))
      grid(
        (0, 0),
        (3, 3),
      )
    })
    group({
      set-origin((0, 3))
      cetz.draw.rotate(x: -90deg)
      content((0, 3), (1, 4), rotate(-50deg, block(
        width: 6em,
        align(left + horizon, td[Storage]),
      )))
      content((1, 3), (2, 4), rotate(-50deg, block(
        width: 6em,
        align(left + horizon, td[Processing]),
      )))
      content((2, 3), (3, 4), rotate(-50deg, block(
        width: 6em,
        align(left + horizon, td[Transmission]),
      )))
      grid(
        (0, 0),
        (3, 3),
      )
    })
  }))),
)
#end-note()

= Threat categorization

#deftbl(
  link(<social-engineering>, [Social Engineering]),
  [Manipulating people to reveal confidential information.],
  link(<software-attacks>, [Software Attacks]),
  [Exploiting vulnerabilities in software to gain access to a system or steal
    data.],
  link(<denial-of-service>, [Denial of Service]),
  [Overloading one or multiple systems to make it unavailable.],
  link(<webapp-attacks>, [Web Application Attacks]),
  [Exploiting vulnerabilities in websites or servers hosting websites.],
  link(<password-attacks>, [Password /\ Authentication Attacks]),
  [Attempting to bypass or compromise login systems to gain unauthorized
    access.],
  link(<physical-threats>, [Physical Attacks]),
  [Bypassing technical controls by accessing physical infrastructure directly.],
)

#add-hd-note(
  "Social engineering",
  [The psychological manipulation of individuals to trick them into revealing
    confidential information or performing actions that can compromise
    security.],
) <social-engineering>

#deftbl(
  [Phishing],
  [Forged emails impersonating legitimate entities.],
  [Spear Phishing],
  [Targeted phishing against specific individuals.],
  [Vishing],
  [Voice-based phishing over phone or video calls.],
  [Smishing],
  [SMS / Text-based phishing.],
)

#add-hd-note(
  "Software attacks",
  [Attacks involving malicious code or malware designed to damage systems, steal
    sensitive data, or gain unauthorized access to systems or services.],
) <software-attacks>

#deftbl(
  [Virus],
  [Malware that attaches to programs and spreads.],
  [Worms],
  [Self-replicating malware that spreads over a network.],
  [Trojan Horse],
  [Malicious software disguised as legitimate applications.],
  [Ransomware],
  [Malware that encrypts victim’s data and demands payment to restore access.],
  [Rootkits],
  [Stealthy tools that hide malicious activity and maintain privileged access.],
)

#add-hd-note(
  "Denial of service",
  [Attacks aims at making a system or service unavailable by overwhelming it
    with excessive traffic or requests.],
) <denial-of-service>

#deftbl(
  [DoS],
  [Single source denial of service attacks.],
  [DDoS],
  [Denial-of-service attacks performed by multiple attackers or attacking
    devices.],
  [Botnet],
  [A network of compromised computers and other devices controlled by an
    attacker and used to together to flood a target with excessive traffic.],
  [SYN-Flood Attack],
  [Sending many connection requests without completing them.],
  [Reflection Attack],
  [Attacker sends requests to a service and spoofs the victim’s IP making the
    service send (many) replies to the victim instead of back to the attacker.],
)

#add-hd-note(
  "Web application attacks",
  [Exploits vulnerabilities in web applications to steal data, manipulate
    content, or gain unauthorized access.],
) <webapp-attacks>

#deftbl(
  [SQL Injection],
  [An attacker inserts malicious SQL commands into an input to manipulate a
    database and access, modify, or delete data.],
  [Cross-Site Scripting (XSS)],
  [An attacker injects malicious scripts into a website that execute in other
    users’ browsers to steal sensitive data.],
  [Cross-Site Request\ Forgery (CSRF)],
  [An attacker tricks a logged-in user’s browser into sending unauthorized
    requests to a web application on their behalf.],
  [Broken Authentication],
  [Weak authentication mechanisms allow attackers to compromise passwords,
    sessions, or identities to gain unauthorized access.],
)

#add-hd-note(
  "Password / Authentication attacks",
  [Attacks that attempt to bypass or compromise login systems to gain
    unauthorized access to a system or service.],
) <password-attacks>

#deftbl(
  [Rainbow Table Attacks],
  [Attackers using precomputed hash lookup tables to reverse weakly hashed
    passwords back into plaintext.],
  [Password Spraying],
  [Attackers trying a few common password like “password” across many accounts
    to avoid lockouts or timeouts.],
  [Credential Stuffing],
  [Attackers using leaked usernames and passwords from previous breaches to
    attempt logins on other services.],
  [Brute Force Attack],
  [Attackers repeatedly try many username and password combinations until they
    successfully gain access to an account.],
)

#add-hd-note(
  "Physical threats",
  [Threats or attacks that affect the physical infrastructure supporting
    information systems, usually bypassing technical controls overall.],
) <physical-threats>

#deftbl(
  [Theft of devices],
  [Attackers physically steal hardware to gain direct access to stored data,
    credential, internal systems, or other sensitive data.],
  [Hardware tampering],
  [An attacker modifies or implants malicious components in physical equipment
    to intercept data, bypass security, or disrupt operations.],
  [Power disruption],
  [Attackers interrupt or manipulate power supply to shut down or destabilize
    critical systems or services impacting availability and business
    continuity.],
  [Environmental damage],
  [Natural or deliberate environmental events that damage infrastructure,
    causing data loss, downtime, or destruction of critical systems (e.g.,
    earthquake, fire).],
)

= Information Security Management

#start-note()
== Information Security Governance

#start-field()
The system by which an organization directs and controls its information
security strategy to ensure that it supports business objectives, manages risk
appropriately, and complies with legal and other regulatory requirements.
#end-note()

#start-note()
Strategic Direction
#start-field()
- Defining security objectives aligned with business goals.
#end-note()

#start-note()
Leadership and Accountability
#start-field()
- Having clear roles and responsibilities for security decisions.
#end-note()

#start-note()
Risk Management
#start-field()
- Defining risks and ensuring they are identified and addressed appropriately.
#end-note()

#start-note()
Regulatory Compliance
#start-field()
- Ensuring adherence to laws and regulations (e.g. NIS2, HIPAA, CRA)
#end-note()

#{
  let node = (p, t, ..args) => node(
    p,
    width: 26em,
    align(left, t),
    ..args.named(),
  )
  let n2 = (p, t, ..args) => node(
    p,
    width: 16em,
    align(left, t),
    ..args.named(),
  )
  align(center, diagram(
    node-stroke: none,
    node((0, 0), [_Responsibilities_]),
    node(
      (0, 1),
      [- Oversee overall corporate security posture (accountable to board)],
    ),
    node((0, 2), [- Brief board, customers, public]),
    node(
      (0, 3),
      [- Set security policy, procedures, program, training for company],
    ),
    node(
      (0, 4),
      [- Respond to security breaches (investigate, mitigate, litigate)],
    ),
    node((0, 5), [- Responsible for independent annual audit coordination]),
    node((0, 6), [- Implement/audit/enforce/assess compliance]),
    node((0, 7), [- Communicate policies, program (training)]),
    node(
      (0, 8),
      [- Implement policy; report security vulnerabilities and breaches],
    ),

    n2((3, 0), [_Functional Role Examples_]),
    n2((3, 1.5), [- Chief Executive Officer], name: <n1>),
    n2(
      (3, 4.5),
      [
        - Chief Security Officer
        - Chief Information Officer
        - Chief Risk Officer
        - Department/Agency Head
      ],
      name: <n2>,
    ),
    n2((3, 6.5), [- Mid-Level Manager], name: <n3>),
    n2((3, 8), [- Enterprise Staff/Employees], name: <n4>),

    edge((2, 1.5), (1, 1.5), (1, 0.6), (0.9, 0.6), corner: right),
    edge((2, 1.5), (1, 1.5), (1, 2.4), (0.9, 2.4), corner: right),

    edge((2, 4.5), (1, 4.5), (1, 2.6), (0.9, 2.6), corner: right),
    edge((2, 4.5), (1, 4.5), (1, 6.4), (0.9, 6.4), corner: right),

    edge((2, 6.5), (1.5, 6.5), (1.5, 5.6), (0.9, 5.6), corner: right),
    edge((2, 6.5), (1.5, 6.5), (1.5, 7.4), (0.9, 7.4), corner: right),

    edge((2, 8), (1, 8), (1, 7.6), (0.9, 7.6), corner: right),
    edge((2, 8), (1, 8), (1, 8.4), (0.9, 8.4), corner: right),
  ))
}

#todo("change <note> to <deftbl>")

#start-note()
== Information Security Management System (ISMS)

#start-field()
A structured framework used to systematically manage and protect an
organization’s assets through various policies, processes and controls

Security governance defines *what* an organization wants to achieve. An ISMS
defines *how* the organization wants to manage it.
#end-note()

#start-note()
Enterprise Information Security Policy (EISP)
#start-field()
- The information security policy that sets the strategic direction and scope
  for all an organization's security efforts.
#end-note()

#start-note()
Risk Management Process
#start-field()
- Definition of processes to identify assets, analyze threats and evaluate risk.
#end-note()

#start-note()
Security Awareness and Training
#start-field()
- Educational programs to ensure employees understand their security
  responsibilities.
#end-note()

#start-note()
Monitoring, Measurement and Audits
#start-field()
- Ongoing evaluation of control effectiveness and ISMS performance.
#end-note()

#start-note()
= Policy

#start-field()
A high-level, management-approved rule that defines mandatory organizational
behavior and translates external laws and regulations into enforceable internal
requirements.
#end-note()

#deftbl(
  [policy],
  [instructions that dictate certain behavior within an organization.],
  [guidelines],
  [non-mandatory recommendations employees may use as a reference.],
  [procedures],
  [step-by-step instructions designed to assist employees in following
    policies.],
  [practices],
  [examples of actions that illustrate compliance with policies.],
  [standard],
  [a detailed statement of what must be done to comply with a policy.],
  [de jure standard],
  [a standard that has been formally evaluated and approved by a formal
    standards organization],
  [de facto standard],
  [a standard that is widely adopted or accepted by a public group.],
)

#{
  let n1 = node.with(width: 26em)
  let n2 = node.with(width: 12em, stroke: none)
  align(center, diagram(
    n2(
      (-1, 0),
      block(width: 100%, place(block(height: 4em, [
        Practices

        - Regulations
        - Laws
      ]))),
      name: <hm>,
    ),
    n2(
      enclose: ((-1, 2), (-1, 4)),
      block(width: 100%, place(dy: -1em)[
        Industry, government and regulatory exemplars
      ]),
      name: <eh>,
    ),
    n2(
      (-1, 6),
      block(width: 100%, place(dy: -1em)[
        Influence organization documents
      ]),
      name: <nah>,
    ),

    n1(
      (0, 0),
      [*Policies*\ Sanctioned by management ],
      fill: colors.darkblue.lighten(80%),
    ),
    edge("-|>", stroke: 3pt),
    edge(<hm>, "<|-", stroke: 1pt),
    n1(
      (0, 2),
      [*Standards*\ Detailed minimum specifications for compliance ],
      fill: colors.darkblue.lighten(70%),
    ),
    edge("-|>", stroke: 3pt),
    edge(<eh>, "<|-", stroke: 1pt),
    n1(
      (0, 4),
      [*Guidelines*\ Recommendations for compliance],
      fill: colors.darkblue.lighten(60%),
    ),
    edge("-|>", stroke: 3pt),
    edge(<eh>, "<|-", stroke: 1pt),
    n1(
      (0, 6),
      [
        *Procedures*\ Step-by-step instructions for compliance
      ],
      fill: colors.darkblue.lighten(50%),
    ),
    edge(<nah>, "<|-", stroke: 1pt),
  ))
}

#start-note()
_What does a policy do?_
#start-field()
Establishes authority, accountability, and responsibilities for protecting
information assets. Provides the foundation for standards, procedures and
guidelines.
#end-note()

#start-note()
_Who is responsible for policies?_
#start-field()
Policies are created and approved by senior management, ensuring organizational
commitment. Management is responsible for enforcement while employees and users
are responsible for compliance.
#end-note()

#start-note()
_How is a policy enforced?_
#start-field()
By clearly communicating it to all relevant parties, integrating it into
standards and procedures, monitoring compliance through audits and oversight,
and applying defined disciplinary measures when violations occur.
#end-note()

#start-note()
Cyber Resilience Act (EU)
#start-field()
- Requires secure-by-design digital products and vulnerability management
  (starting December 2027).
#end-note()

#start-note()
Health Insurance Portability and Accountability Act (U.S.)
#start-field()
- Requires administrative, technical, and physical safeguards for protecting
  patient health data from disclosure.
#end-note()

#start-note()
NIS2 Directive (EU)
#start-field()
- Mandates cybersecurity risk management and incident reporting for critical and
  important entities.
#end-note()

#start-note()
Local Laws
#start-field()
- Many regions have their own data protection or breach notification laws in
  additional to national or EU regulations.
#end-note()

#start-note()
== Designing effective policies

#start-field()
+ Development
  - Policies must align with organizational goals, business risks and legal
    requirements.
+ Distribution
  - Policies must be distributed to all affected entities in a timely manner.
+ Comprehension
  - Policies must be readable for, available to and read by all affected
    entities.
+ Compliance
  - Policies must be formally agreed to by act or affirmation.
+ Enforcement
  - Policies must be uniformly applied to all affected entities.
+ Review
  - Policies must be reviewed regularly in a changing environment.
#end-note()

#start-note()
== Enterprise Information Security Policy (EISP)

#start-field()
The high-level information security policy that sets the strategic direction,
scope and tone for all an organization's security efforts and policies.

- Guidance for the development, implementation and management of the security
  program.
- Sets the requirements that must be met by the information security blueprint.
- Defines the purpose, scope, constraints and applicability of the security
  program.
- Assigns responsibilities for the various areas of information security.
- Addresses legal compliance.
#end-note()

#start-note()
=== Elements of an EISP

#start-field()
Although the content of EISP documents varies among organizations, most EISP
documents should include the following elements.

- Statement of Purpose
  - Statement of intent that defines the scope, objectives, and purpose of the
    enterprise information security policy and establishes its role as the
    foundation for all supporting security documents.
- Information Security Elements
  - Definition of information security that outlines the core principles and
    concepts, including confidentiality, integrity, and availability, guiding
    the organization’s security efforts.
- Need for Information Security
  - Definition of the importance of information security within an organization
    and its legal and ethical responsibility to protect information about
    customers, employees, and markets.
- Information Security Responsibilities and Roles
  - Description of the organizational structure that supports information
    security, including defined roles and responsibilities for management,
    employees, and users, as well as responsibility for maintaining the policy
    itself.
#end-note()

#start-note()
== Issue-Specific Security Policy

#start-field()
An organizational policy that provides detailed, targeted guidance to instruct
members of an organization in the use of a specific resource.

- Supports the EISP by translating it into an issue-specific guidance.
- Establishes rules for access, monitoring, and protection of the resource.
- Defines acceptable and unacceptable use of the specified technology or
  resource.
- Assigns responsibilities and accountability to users, administrators, and
  management.
#end-note()

#start-note()
= Risk analysis

#start-field()
The process of identifying assets, threats, and vulnerabilities, and evaluating
the likelihood and impact of potential adverse events to determine the level of
risk.

#diagram(
  node((0, 0), [Identify Assets], name: <n1>),
  edge("->"),
  node((1, 0), [Identify Threats], name: <n2>),
  edge("->"),
  node((2, 0), [Identify Vulnerabilities], name: <n3>),
  edge("->"),
  node((3, 0), [Assess Likelihood], name: <n4>),
  edge("->"),
  node((4, 0), [Assess impact], name: <n5>),
  node((2, 2), [Determine Risk Level], name: <ne>),
  edge(<n1>, (0, 1), (2, 1), <ne>, "->"),
  edge(<n2>, (1, 1), (2, 1), <ne>, "->"),
  edge(<n3>, (2, 1), <ne>, "->"),
  edge(<n4>, (3, 1), (2, 1), <ne>, "->"),
  edge(<n5>, (4, 1), (2, 1), <ne>, "->"),
)
#end-note()

== Identifying Assets

#deftbl(
  [Asset],
  [Any resource that has some kind of value to an organization and therefore
    requires protection.],
  [Information Assets],
  [Customer data, intellectual property, source code, etc.],
  [Technical Assets],
  [Services, applications, databases, networks, etc.],
  [Physical Assets],
  [Servers, devices, facilities, infrastructure, etc.],
  [Human Assets],
  [Employees, administrators, contractors, key personnel, etc.],
  [Business Process Assets],
  [Critical operational workflows],
)

#start-note()
== Classifying Assets

#start-field()
The process of assigning every asset to a class based on their value,
sensitivity and impact if compromised
#end-note()

#deftbl(
  [Public],
  [Information that can be shared without risk],
  [Internal],
  [Information for organization internal use only],
  [Confidential],
  [Sensitive information that could cause harm if disclosed],
  [Restricted],
  [Highly sensitive, strictly limited and strongly protected information],
)

#start-note()
== Identifying Threats

#start-field()
A potential event, actor, or action that could exploit a vulnerability and cause
harm to an asset.

Examples: Power outage, insider threat, vishing attack
#end-note()

#start-note()
== Security Controls

#start-field()
Measures to reduce risk by detecting, preventing, responding to, or mitigating
threats to organizational assets.
#end-note()
#todo("belongs into information security management")

=== Types

#deftbl(
  [Administrative /\ Management Controls],
  [Policies, procedures, security training, security governance, etc.],
  [Technical / Logical Controls],
  [Firewalls, encryption, access control systems, system hardening, etc.],
  [Physical Controls],
  [Physical locks, surveillance cameras, secure access badges, turnstiles,
    etc.],
)

=== By Function

#deftbl(
  [Preventive Controls],
  [Stop incidents before they occur.\ e.g., Firewalls, access control,
    encryption, etc.],
  [Detective Controls],
  [Identify incidents when they occur.\ e.g., Intrusion detection, log
    monitoring, SIEM, CCTV, etc.],
  [Corrective Controls],
  [Limit damage and restore systems after an incident.\ e.g., Backups, system
    restore, incident response, etc.],
  [Deterrent Controls],
  [Discourage malicious behavior.\ e.g., Warning banners, monitoring notices,
    disciplinary policies, etc.],
  [Compensating Controls],
  [Reduce risk when a primary control cannot be implemented.\ e.g., Network
    isolation, layered security, alternative safeguards, etc.],
)

#start-note()
== Business Continuity Management

#start-field()
Ensures that critical business functions can continue during and after incidents
or disruptions such as cyberattacks, system failures, or physical incidents.

Even with strong security controls in place, incidents can and will still occur
at some point. BCM prepares the organization to operate and recover during these
times.
#end-note()

=== Key Objectives

#add-note(
  format: note-answer,
  "Key Business Continuity Management Objectives",
  [
    - Maintain critical operations during incidents. \ e.g., backups, redundant
      services, manual processing, etc.
    - Minimize downtime and financial impact. \ e.g., fast system restore,
      emergency support contracts, incident response team, etc.
    - Protect people, assets and reputation \ e.g., evacuation plans, fire
      suppression systems, customer notification processes, etc.
    - Enable fast and structured recovery \ e.g., disaster recovery playbooks,
      tested backup restoration, post-incident review processes, etc.
  ],
)

#start-note()
== Security and Awareness Training

#start-field()
A coordinated program designed to ensure that all members of an organization
understand their security responsibilities and have the knowledge and skills to
protect information assets.

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  table-header(
    [],
    [Awareness (Level 1)],
    [Training (Level 2)],
    [Education (Level 3)],
  ),
  [Objective],
  [
    Seeks to teach members of an organization *what* security is and what to do
    in certain situations
  ],
  [
    Seeks to train members of an organization *how* they should react and
    respond to certain situations
  ],

  [
    Seeks to educate members of an organization as to *why* the organization
    reacts the way it does
  ],

  [Complexity\ Level],
  [
    Offers *basic information* about threats and responses
  ],
  [
    Offers more *detailed knowledge* about detecting threats and teaches skills
    needed for effective reaction
  ],
  [
    Offers the background and *depth of knowledge* to gain insight into how
    processes are developed and enables ongoing improvement
  ],

  [Teaching\ Method],
  [
    - Videos
    - Newsletters
    - Posters
    - Informal Training
  ],
  [
    - Informal Training
    - Workshops
    - Hands-on Practice
  ],
  [
    - Theoretical Instruction
    - Discussions / Seminars
    - Background Reading
  ],

  [Impact\ timeframe], [Short-term], [Intermediate], [Long-term],
)
#end-note()

#start-note()
== Gap Analysis

#start-field()
The process of comparing an organization’s current security posture with a
required or desired target to identify missing or insufficient controls.

- Risk Analysis: What could go wrong?
- Gap Analysis: Where are we non-compliant or under-protected?

#align(center, diagram(
  node((0, 0), [Define a target\ framework]),
  edge("->"),
  node((1, 0), [Assess the\ current state]),
  edge("->"),
  node((2, 0), [Identify gaps\ and assess risk]),
  edge("->"),
  node((3, 0), [Evaluate and\ prioritize gaps]),
  edge("->"),
  node((4, 0), [Develop a\ remediation plan]),
))
#end-note()

#start-note()
== Security Framework

#start-field()
A structured set of principles, processes, and controls that organizations use
to manage risks and protect their information systems, assets, and operations.
#end-note()

#deftbl(
  term: "Framework",
  [ISO/IEC 27000],
  [Global standard for information security management systems (ISMS).],
  [NIST Cybersecurity Framework],
  [Practical framework for managing cyber risk],
  [CIS Controls],
  [Defines 18 highly practical technical security controls],
  [ISACA CORBIT],
  [An IT governance and risk management framework.],
)

#start-note()
== ISO/IEC 2700

#start-field()
A set of standards for ISMS, helping organizations systematically protect
information assets using a risk-based approach.
#end-note()

#deftbl(
  term: "Standard",
  [ISO/IEC 27000],
  [Introduction, terminology, and key concepts (e.g., risk, asset, control,
    etc.)],
  [ISO/IEC 27001],
  [Defines requirements to establish, implement, maintain, and improve an
    ISMS.],
  [ISO/IEC 27002],
  [Practical guidance for implementing controls.],
  [ISO/IEC 27005],
  [Focuses on risk management methodology.],
  [ISO/IEC 27017],
  [Additional guidance for cloud services.],
  [ISO/IEC 27018],
  [Focuses on privacy and personal data protection in cloud environments.],
)

#start-note()
== NIST Cybersecurity Framework

#start-field()
A risk-based guideline that helps organizations to structure, manage, and
improve their cybersecurity activities across the full lifecycle of prevention,
detection, and response.

- It’s organized into five core functions; Identify, Protect, Detect, Respond,
  Recover.
- Provides categories and subcategories of cybersecurity outcomes and controls.
- Includes implementation tiers to assess cybersecurity maturity.
- Is very flexible and adaptable to any organization or business sector.
- Not certifiable, primarily used as guidance and best practice.
#end-note()

== Risk, Vulnerabilities and Threats

#start-note()
=== Vulnerabilities

#start-field()
A potential weakness in an asset or its defensive control system. Can be *known*
or *unknown*.

Examples:
- Software vulnerabilities (Bugs, design flaws, ...).
- Human vulnerabilities (sharing passwords, ...).
#end-note()

#start-note()
=== Threat

#start-field()
A potential malicious action, or event that aims to damage, or steal
unauthorized access to assets. A threat exploits system vulnerabilities.

- Threat: What?
- Threat Actor: Who?
- Threat Vector: How?
#end-note()

#start-note()
=== Threat Actors

#start-field()
#table(
  columns: (1fr, 1fr),
  table-header([Motivations], [Actor Types]),
  [
    - Service disruptions
    - Data exfiltration
    - Disinformation
    - Chaotic / Vandalism
    - Financial
      - Blackmailing
      - Fraud
    - Political
  ],

  [
    - Hackers
    - Unskilled Attackers & Script Kiddies
    - Hacker Teams & Hacktivists
    - Nation-State Actors
    - Organized Crime
    - Internal Threat Actors
  ],
)
#end-note()

#start-note()
=== Threat Vector

#start-field()
The path, method, or delivery mechanism that a threat uses to reach an asset and
exploit a vulnerability.

Types:
- Software Vectors (Bugs, Virus, ...)
- Network Vectors (Bluetooth, Open Ports, Remote Network, ...)
- Lure-Based Vectors (Drop Attacks with USB Sticks, Trojans, ...)
- Message-Based Vectors (SMS, Email, IM, Web and Social Media, ...)
- Supply Chain Vectors (Updates, Libraries, ...)
#end-note()

#start-note()
=== Attack surface

#start-field()
The sum of vulnerabilities, pathways, or methods (Threat vectors) that hackers
can use to gain unauthorized access to the network or sensitive data, or to
carry out a cyberattack.
#end-note()

#start-note()
=== Risk

#start-field()
The probability of an unwanted occurrence, such as an undesirable event or loss.

- The definition of risk implies threats and vulnerabilities: A risk is only
  here if we have an existing vulnerability, threat, and threat vector!
- Risk = Vulnerability (Value & Exposure) + Threat (Threat Actor & Threat
  vector)

At what cost are we willing to accept what risk? The answer to that question
gives us risk management.
#end-note()

#start-note()
== Risk Management

#start-field()
The process of identifying, assessing, prioritizing and mitigating threats to an
asset from an organisation.
#end-note()


#start-note()
_Risk management framework_

#start-field()
Structure of the strategic planning and design of the entirety of the risk
management efforts (planning).
#end-note()


#start-note()
_Risk management process_

#start-field()
Implementation, analysis, evaluation of the risk management framework (doing).
#end-note()

#todo("slides 17")

#start-note()
=== RM Framework

#start-field()
+ _Executive Governance & Support_: Support from management and users.
+ _Framework Design_: Defining the methods and risk appetite strategy.
+ _Framework Implementation_: Rollout of the plan (through →RM process).
+ _Monitoring & Review_: How effective is the entire system?
+ _Continuous Improvement_: Continuous adaption to new , or existing threats.
#end-note()

==== Executive Governance and Support

#todo("slides 19")

#start-note()
==== Framework Design

#start-field()
Defining the methods and risk appetite strategy
#end-note()

#deftbl(
  [Risk appetite (strategic)],
  [The quantity of risk that organizations are willing to accept, to achieve
    their goals.],
  [Risk tolerance (specific)],
  [The acceptable risk organizations are willing to accept for a specific
    asset.],
  [Residual risk],
  [The risk that still remains after all controls have been applied. ],
)

#start-note()
==== Framework Implementation

#start-field()
Framework Implementation starts after:

- The RM framework and process is finished designing.
- The structure of the RM process & framework is defined.

The methodologies are dependent on the risk appetite:

- Direct rollout
- Pilot-test
- Phased approach
#end-note()

#start-note()
==== Monitoring & Review

#start-field()
- How successful was the framework in the last cycle?
  - Designing
  - Implementing
- What issues require adjustments to the plan?
#end-note()

#start-note()
=== Risk Management Process

#start-field()
#td([*Risk assessment*]): The identification, analysis, and evaluation of risk
as initial parts of risk management.

#tg([*Risk treatment & Risk Owner*]): The application of safeguards or controls
to reduce the risks to an organization’s information assets to an acceptable
level.

+ #td([*Risk identification*]): Where and what is the risk?
+ #td([*Risk analysis*]): How severe is the current level of risk?
+ #td([*Risk evaluation*]): Is the current level of risk acceptable?
+ #tg([*Risk treatment*]): What do I need to do to bring the risk to an
  acceptable level?
#end-note()

#start-note()
==== Risk Identification

#start-field()
The recognition, enumeration, and documentation of risks to an organization’s
information assets.

Where and what is the risk?

- What are the assets of the organisation? (Internal Asset Register, Weighted
  Asset Table)
  - Data, Software, Hardware, Networks, Employees, procedures, ...
- What are the threats of the organisation? (#link(
    "https://attack.mitre.org/",
    "ATT&CK",
  ) is a globally-accessible knowledge base).
  - Human error, Attacks from hackers, forces of nature, day zero attacks ...
- What are the vulnerabilities? (#link("https://www.cve.org/", "CVE") and #link(
    "https://www.first.org/cvss/calculator/3.1",
    "CVSS",
  ) helps with that question).
  - Lack of training, known bugs in the system, day zero exploit
- Precision is key: If THIS then THAT, because OF ...
#end-note()

=== CVE & CVSS

#add-note(format: note-answer, "CVE", [
  - A Common Vulnerabilities and Exposures (CVE) is an industry-wide standard
    identification number for vulnerabilities.
])

#add-note(format: note-answer, "CVSS", [
  - The Common Vulnerability Scoring System (CVSS) uses the CIA triad principles
    within the metrics used to calculate the CVVS base score and assigns
    severity scores to a vulnerability
])

#start-note()
=== Risk Analysis

#start-field()
A determination of the extent to which an organization’s information assets are
exposed to risk.

Identify the severity of every identified threat and vulnerability.

- What is the probability of an attack?
- What would be the impact of an attack?
  - Quantitative risk analysis assigns real dollar figures to the loss of an
    asset.
  - Qualitative risk analysis assigns subjective and intangible values to the
    loss of an asset.
- Existing Security Controls shall be considered
#end-note()

#start-note()
=== Quantitative Risk Analysis

#start-field()
+ Assign Asset Value (AV)
+ Calculate Exposure Factor (EF)
+ Calculate single loss expectancy (SLE)
+ Assess the annualized rate of occurrence (ARO)
+ Derive the annualized loss expectancy (ALE)
+ Perform cost/benfit analysis of countermeasures
#end-note()

#start-note()
==== AV

#start-field()
+ Identify the organization’s information assets.
+ Classify them.
+ Categorize them into useful groups.
+ Prioritize them by overall importance.
#end-note()

#exbox(title: "Weighted Asset Table", table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  align: center,
  table-header(
    [],
    [],
    [Impact on\ Revenue],
    [Impact on\ Profitability],
    [Impact on\ Reputation],
    [],
    [],
  ),
  [*\#*], [], [*0.3*], [*0.4*], [*0.3*], [*TOTAL\ (1.0)*], [*Importance*],
  [1], [Customer order via SSL], [5], [5], [5], [5], [Critically\ Important],
  [2],
  [Customer service request via e-mail],
  [3],
  [3],
  [5],
  [3.6],
  [Important],
  ..range(7).map(_ => $dots.v$),
))

#start-note()
==== EF

#start-field()
_Exposure factor (EF)_: Represents the percentage of loss that an organization
would experience if a specific asset is violated by a realized risk.
- In most cases, a realized risk does not result in the total loss of an asset.
  The EF simply indicates the expect.
#end-note()

#start-note()
==== SLE

#start-field()
_Single loss expectancy (SLE)_: The cost associated with a single realized risk
against a specific asset. It indicates the exact amount of loss an organization
would experience if an asset were harmed by a specific threat occurring.
- SLE = asset value (AV) × exposure factor (EF)
- Example: if an asset is valued at \$200,000 and it has an EF of 45 % for a
  specific threat, then the SLE of the threat for that asset is \$90,000.
#end-note()

#start-note()
==== ARO

#start-field()
_Annualized rate of occurrence (ARO)_: The expected frequency with which a
specific threat or risk will occur within a single year.
- Example: The ARO of an earthquake in Paris may be .00001, whereas the ARO of
  an earthquake in San Francisco may be .03 (for a 6.7+ magnitude).
#end-note()

#start-note()
==== ALE

#start-field()
_Annualized loss expectancy (ALE)_: The possible yearly cost of all instances of
a specific realized threat against a specific asset.
- ALE = single loss expectancy (SLE) ⋅annualized rate of occurrence (ARO)
- If the SLE of an asset is \$90,000 and the ARO for a specific threat (such as
  total power loss) is .5, then the ALE is \$45,000.\ On the other hand, if the
  ARO for a specific threat (such as compromised user account) is 15, then the
  ALE would be \$1,350,00
#end-note()

#start-note()
==== ALE with Safeguards

#start-field()
- You must calculate the ALE for the asset if the safeguard is implemented.
  - This requires a new EF and ARO specific to the safeguard.
  - The whole point of a safeguard is to reduce the ARO and/or reduce the SLE.
    The best of all possible safeguards would reduce the ARO to zero.
  - In most cases, the EF to an asset remains the same even with an applied
    safeguard because if the safeguard fails, the loss on the asset is usually
    the same as when there is no safeguard.
- Safeguard Costs
  - You must first compile a list of safeguards for each threat. Then you assign
    each safeguard a deployment value = ACS (Annual cost of the safeguard).
#end-note()

#start-note()
==== Value of a Safeguard

#start-field()
Net Value or Cost/Benefit of a safeguard:

- Negative value: not a responsible choice.
- Positive value: Then the value represents the yearly savings in cost that you
  CAN have (because the rate of occurrence is just an expected value).

Safety needs to be cost effective. Do not use more resources or money for the
protection of an asset as the value of the asset itself!
#end-note()

#start-note()
=== Risk Evaluation

#start-field()
The process of comparing an information asset's risk rating to the numerical
representation of the organization’s risk appetite or risk threshold to
determine if risk treatment is required.

Risk Evaluation: Compare the risk with the risk appetite of the organization.

- Can the company live with the analysed level of risk (From the CVSS, the
  quantitative risk analysis, qualitative risk analysis)?
- Levels: Expansionary, Conservative or Neutral

The Risk appetite from the RM Framework must be translated into a value so it
can be compared to each analysed risk.

- For the quantitative risk analysis, the risk appetite can be translated into a
  numerical value!

Goal: The risk must be smaller or equal as the risk appetite.

- Important Indicators for Business Impact:
  - Maximum Tolerable Downtime (MTD)
  - Recovery Point Objective (RPO)
  - Recovery Time Objective (RTO) & Work Recovery Time (WRT)
#end-note()

#start-note()
=== Risk Treatment

#start-field()
Mitigation risk treatment strategy: The risk treatment strategy that attempts to
eliminate or reduce any remaining uncontrolled risk through the application of
additional controls and safeguards in an effort to change the likelihood of a
successful attack on an information asset; also known as the defense strategy.

The company now has a list of information assets with unacceptable levels of
risk.

- The appropriate strategy must be selected and applied.

Four basic strategies to treat risk:
+ Mitigation: Apply safeguards that eliminate or reduce the remaining
  uncontrolled risk.
  - Example: Firewall, Training, ...
+ Transfer: Shift risks to other areas or outside entities.
  - Example: Outsourcing
+ Acceptance: Understand the consequences of choosing to leave an information
  assets vulnerability facing the current risk level (after formal evaluation).
+ Termination: Remove or discontinue the asset from the organization's operating
  environment.
#end-note()

#start-note()
==== Mitigation

#start-field()
- Fix vulnerabilities
- Applying controls (tools, processes, rules to mitigate risk)
  - Endpoint Hardening (preventive Control): Secure a "endpoint" (device:
    laptop, server, ...) by reducing its vulnerabilities and shut down potential
    threat vectors!
- Reduce final impact (If zero-day attacks, unknown vulnerabilities, or a taken
  risk happen)
  - EDR (Endpoint Detection and Response): Software that watches for suspicious
    behaviour and responds with certain measures.
  - XDR (Extended Detection and Response): Watching everywhere (not just on
    endpoints) and respond with certain measures (shut down infected laptop,
    ...)
#end-note()

=== Other RM Frameworks

- OCTAVE (Operationally Critical Threat, Asset and Vulnerability Evaluation) by
  the Carnegie Mellon University.
- FAIR (Factor Analysis of Information Risk) by Jack A. Jones.
- ISO Standards: ISO 27005 and ISO 31000: (explanation:
  https://en.wikipedia.org/wiki/ISO/IEC_27005).
- NIST Risk Management Framework (RMF): https://csrc.nist.gov/publications/sp


#start-note()
= Identity & Access Management (IAM)

#start-field()
IAM deals with provisioning and protecting digital identities and user access
permissions. Or in other words: The right people can access the right resources
for the right reasons at the right time. To ensure this we need Access Controls.
#end-note()

#start-note()
== Access Control

#start-field()
Any hardware, software, or administrative policy or procedure that controls
access to resources. The selective method by which systems specify who may use a
particular resource and how they may use it.

The goal is to:

- PROVIDE access to authorized subjects
- PREVENT access to unauthorized access attempts and unauthorized subjects
#end-note()

#deftbl(
  [Subject],
  [
    Active entity that accesses a passive object.

    - Anything that can access a resource can be a subject: users, programs,
      processes, services, computers,...
  ],
  [Object],
  [
    Passive entity that provides information to subjects
    - Anything that can provide resources: files, databases, computers,
      programs, processes, services, printers, ...
  ],
)

#align(center, diagram(
  node-shape: fletcher.shapes.pill,
  node((0, 0), "Subject"),
  edge("-|>", label: "access"),
  node((8, 0), "Object"),
))

=== Control methods

#deftbl(
  [Physical controls],
  [
    Items that you can physically touch. Included are physical mechanisms
    deployed to prevent, monitor, or detect direct contact with systems or areas
    within a facility
    - Examples: guards, fences, motion detectors, locked doors, sealed windows,
      lights, cable protection, laptop locks, badges, swipe cards, guard dogs,
      video cameras, mantraps, and alarms
  ],
  [Technical or\ logical controls],
  [Hardware or software mechanisms used to manage access and to provide
    protection for resources and systems
    - Examples: authentication methods (username, passwords, biometrics,...),
      encryption, access control lists, protocols,...
  ],
  [Administrative\ controls],
  [Policies and procedures defined by an organization’s security policy or other
    regulations or requirements
    - Examples: policies, procedures, hiring practices, background checks, data
      classifications and labeling, security training,...
  ],
)

#align(center, diagram(
  node-shape: fletcher.shapes.ellipse,
  node((0, 0), [Physical controls], name: <p>, stroke: none),
  node((0, 2), [Technical or logical controls], name: <t>, stroke: none),
  node((0, 4), [Administrative controls], name: <a>, stroke: none),
  node((0, 5), [Assets], name: <ass>, fill: colors-l.purple, inset: 1em),
  node(enclose: (<ass>, <a>), inset: 1em),
  node(enclose: (<ass>, <a>, <t>, (0, 7)), inset: 2em),
  node(enclose: (<ass>, <a>, <t>, <p>, (0, 8), (-8, 0), (8, 0)), inset: 2.5em),
))

== Mechanisms

#align(center, diagram(
  node-shape: fletcher.shapes.ellipse,
  node-stroke: none,
  node((0, 0), [Identification]),
  edge("-|>", corner: left),
  node((1, 1), [Authentication]),
  edge("-|>", corner: left),
  node((2, 2), [Authorization]),
  edge("-|>", corner: left),
  node((3, 3), [Auditing]),
  edge("-|>", corner: left),
  node((4, 4), [Accounting]),
))

#start-note()
=== Identification

#start-field()
The subject is claiming an identity.

- Example: Typing a username, swiping a smartcard, waving a token device,
  speaking a phrase, or positioning your face, hand, or finger in front of a
  camera or in proximity to a scanning device

*Important*: All subjects must have unique identities

- IT systems track activity by identities, not by the subjects themselves
- A subject’s identity is typically labeled as, or considered to be, public
  information

A subject must provide an identity to a system to start the other processes
(authentication, authorization, and accountability)
#end-note()

#start-note()
=== Authentication

#start-field()
The process of verifying that the claimed identity (from identification) is
valid

- Example: password
- Identification and authentication are often used together as a single two-step
  process

Authentication information used to verify identity is private information and
needs to be protected

To authenticate the claimed identity it is common to use multiple factors These
factors are often categorized in three different categories:

+ Something you know
  - A Type 1 authentication factor is something you know. Passwords, PINs, ...
+ Something you have
  - A Type 2 authentication factor is something you have. Physical devices that
    a user possesses can help them provide authentication
+ Something you are / you do
  - A Type 3 authentication factor is something you are or something you do. It
    is a physical characteristic of a person identified with different types of
    biometrics
#end-note()

#start-note()
==== Authentication Schemes

#start-field()
+ Basic Authentication: Classical username / password pair transmitted in the
  clear
+ One Time Passwords: Transmitted in the clear but used only once
+ Challenge / Response: Response is a function of password and one-time
  challenge
+ Anonymous Key Exchange: Exchange credentials over unauthenticated secure
  channel
+ Zero-Knowledge Password Proofs: Does not permit offline-based password attacks
+ Server Certificates plus User Authentication: Transmit user password over
  unilaterally authenticated secure channel
+ Mutual Public Key Authentication: Bilateral use of public key signatures

_Attack vulnerability Matrix_
#align(center, table(
  columns: 8,
  table.header(align(left)[Attack], [1], [2], [3], [4], [5], [6], [7]),
  align(left)[Passive Password Sniffing], cr, [], [], [], [], [], [],
  align(left)[Offline Brute Force Password Attack], cr, [], cr, cr, [], [], [],

  align(left)[Active Man-in-the-Middle Attack], cr, cr, cr, cr, [], [], [],
  align(left)[Identity Theft on Server], cr, cr, cr, cr, cr, cr, [],
  align(left)[CA Compromise], [], [], [], [], [], cr, cr,
))
#end-note()

#start-note()
==== Type 1 Factor: Passwords

#start-field()
Passwords are typically static. They are the weakest form of authentication

- Users often choose passwords that are easy to remember and therefore easy to
  guess or crack
- Randomly generated passwords are hard to remember, and many users write them
  down
- Users often share their passwords, or forget them
- Passwords are rarely stored in plaintext.
  - A system will create a hash of a password using a hashing algorithm
- Best practices and policies
  - Enforce a minimum length
  - Complexity rules (uppercase/lowercase, non-alphanumeric, etc...)
  - Ageing and expiration
  - Reuse and history
- Password managers mitigate the risk of poor credential management
#end-note()

#start-note()
==== Type 2 Factor: Tokens

#start-field()
A token device, or hardware token, is a device that users can carry with them

- An authentication server stores the details of the token, so at any moment,
  the server knows what number is displayed on the user's token
#end-note()

#start-note()
Hard Authentication Tokens
#start-field()
- No transmission of the token itself e.g. Smartcards, Hardware OTP Token
#end-note()

#start-note()
Soft Authentication Tokens
#start-field()
- Software token transmitted to the user e.g. via Authenticator App, SMS, Email
  or phone
#end-note()

#start-note()
Dynamic Password Tokens
#start-field()
- Synchronous create synchronous dynamic passwords are synchronized with an
  authentication server
- Asynchronous asynchronous dynamic password is based on a Challenge-Response
  principle
#end-note()

#start-note()
==== Type 2 Factor: Smartcard

#start-field()
A smartcard is a credit card–sized ID or badge and has an integrated circuit
chip embedded in it

- Smartcards store information about the authorized user that is used for
  identification and/or authentication purposes
- Implements certificate-based authentication (private key and sometimes a PIN
  to activate the card)
- Most current smartcards include a microprocessor and one or more certificates.
  The certificates are used for asymmetric cryptography such as encrypting data
  or digitally signing email
- Smartcards are tamper-resistant and provide users with an easy way to carry
  and use complex encryption keys
#end-note()

#start-note()
==== Type 2 Factor: One-Time Passwords

#start-field()
Onetime passwords are dynamic passwords that change every time they are used

- Onetime password generators are token devices that create passwords
- The PIN can be provided via a software application running on the user’s
  device (e.g., smartphone)
#end-note()

#start-note()
TOTP (Time-based One-Time Password)
#start-field()
- Uses a timestamp and remains valid for a certain timeframe, such as 30 seconds
- This is similar to the synchronous dynamic passwords used by tokens
#end-note()

#start-note()
HOTP (HMAC-based One-Time Password)
#start-field()
- Includes a hash function to create onetime passwords. It creates HOTP values
  of six to eight numbers
- This is similar to the asynchronous dynamic passwords created by tokens. The
  HOTP value remains valid until used
#end-note()

#start-note()
==== Type 3 Factor: Biometrics

#start-field()
Biometric authentication uses physiological characteristics to provide
authentication for a provided identification.

Errors: Biometrics make measurements and compare them with unique points of
reference. This leads to errors (measurements always have errors):

- False reject rate (Type 1 Error): percentage of authorized users who are
  denied access
- False accept rate (Type 2 Error): percentage of unauthorized users who are
  granted access
- Crossover error rate (CER): The point at which the rate of false rejections
  equals the rate of false acceptances
#end-note()

#start-note()
==== Multifactor Authentication

#start-field()
Multifactor authentication is any authentication using two or more factors

- For a positive authentication, elements from at least two, and preferably
  three factors should be verified
  - When two authentication methods of the same factor are used together, the
    strength of the authentication is no greater than it would be if just one
    method were used
  - Using more types or factors results in more secure authentication
#end-note()

#start-note()
==== Authentication factors

Numbered from weak to strong

#start-field()
+ Type 1: Something you know
+ Type 2: Something you have
+ Type 3: Something you are/ you do
+ Multi-Factor: 2 types
+ Multi-Factor: 3 types
#end-note()

#start-note()
==== Secondary Authentication Factors

#start-field()
In addition to the three primary authentication factors, there are some others

- Somewhere You Are
  - The somewhere-you-are factor identifies a subject's location based on a
    specific computer, a geographic location identified by an Internet Protocol
    (IP) address, or a phone number identified by caller ID
- Somewhere You Aren't
  - Many IAM systems use geolocation technologies to identify suspicious
    activity
  - For example, imagine that a user typically logs on with an IP address in
    Switzerland. If a user is trying to log on from a location in India, it can
    block the access even if the user has the correct username and password
#end-note()

#start-note()
==== Authentication Frameworks

#start-field()
- Kerberos: Create Authentication through a trusted third party.
- RADIUS: Provide centralized authentication, authorization, and accounting
  (AAA) for network access.
#end-note()

#start-note()
===== Kerberos

#start-field()
#{
  let node = node.with(height: 4em, width: 8em)
  align(center, diagram(
    spacing: (14em, 6em),
    node((0, 0), [Kerberos\ Authentication], name: <k>),
    node((1, 0), [Ticket\ Granting\ Service], name: <t>),
    node((0, 1), [Client], name: <c>),
    node((1, 1), [Server], name: <s>),
    edge(<k>, <c>, "-|>", shift: .05),
    edge(<t>, <c>, "-|>", shift: .1),

    edge(<c>, <k>, "-|>", shift: .05, label: box(
      width: 8em,
      height: 2em,
      fill: colors.bg,
      place(dx: 1.5em)[1. Authenticate\ user],
    )),
    edge(<c>, <t>, "-|>", shift: .1, label: box(
      width: 11em,
      height: 2em,
      fill: colors.bg,
      place(dx: 3em)[2. Access control\ for server],
    )),
    edge(<c>, <s>, "-|>", label: [3. Communication]),
  ))
}

An authentication system that uses symmetric key encryption to validate an
individual user’s access to various network resources by keeping a database
containing the private keys of clients and servers that are in the
authentication domain it supervises.

- Authentication in UNIX-based TCP/IP networks
- Use of symmetrical cryptography (DES)
- Relies on the mediation services of a trusted referee or notary
- Based on the work by Needham and Schroeder on trusted third-party protocols as
  well as Denning and Sacco's modifications of these
- Current release is Kerberos v5 (#rfc(1510), September 1993)
- V5 supports additional encryption ciphers besides DES
#end-note()

#deftbl(
  [Principal],
  [A Kerberos participant],
  [Principal's Master Key ($"MKey"_p$)],
  [A long-term secret shared between the principal (user, service, or host) and
    the Key Distribution Center (KDC). This key is typically derived from the
    principal's password and is used to encrypt and decrypt authentication
    tickets.],
  [Kerberos Ticket],
  [Temporary credential that allows a user to access specific network services],
  [Authentication Server (AS)],
  [Verifies who the client is, gives TGT],
  [Ticket Granting Server (TGS)],
  [Grants access to specific services, gives ST],
  [Ticket Granting Ticket (TGT)],
  [Given by the AS],
  [Service Ticket (ST)],
  [Given by the TGS],
  [Key Distribution Center (KDC)],
  [A server that verifies and manages authentication credentials and distributes
    session keys to users and services within a network],
)

#start-note()
Kerberos Step-By-Step
#start-field()
+ The user wants to get authenticated at a Service.
+ The user sends a request to the Authentication Server (KDC) asking for a
  Ticket Granting Ticket (TGT). This request is encrypted with the hash of the
  user's password.
+ The Authentication Server looks up the user, authenticates him using the
  hashed password and sends back the TGT. (notice, the password itself never
  travels across the network)
+ The user wants to access a specific service. He sends the TGT to the Ticket
  Granting Server (TGS)
+ The TGS verifies the TGT and issues a Service Ticket to the client
+ The client presents this Service Ticket directly to the Service he wants to
  use.
+ The Service decrypts the ticket, verifies the client and grants access. He can
  also send a message back to the client to prove its own identity.
#end-note()

#todo[diagrams (slides 20)]

#start-note()
===== Remote Authentication Dial-In User Service (RADIUS)

#start-field()
A networking protocol that provides centralized Authentication, Authorization
and Accounting (AAA) management for users who use a network service.

Used to secure network nodes: Enterprice Wi-Fi (802.1x), VPNs, Switches
#end-note()

#start-note()
AAA
#start-field()
- Authentication: Verifying the user's identity
- Authorization: Granting specific network privileges (assigning specific IP,
  ...)
- Accounting: Tracking network resource for auditing, billing, ...
#end-note()

#start-note()
RADIUS Architecture
#start-field()
+ User requests network access from the NAS
+ NAS prompts the RADIUS server for credentials (username / password, or
  certificate)
+ RADIUS server evaluates the request and returns one of three responses:
  - Access-Accept: User is authenticated, NAS grants network access
  - Access-Reject: Invalid credentials, NAS denies access
  - Access-Challenge: Server requires more information (MFA, or Token)
+ When connected, NAS sends Accounting-Request to log the session.
#end-note()

#start-note()
===== RADIUS vs Kerberos Vulnerability Matrix

#start-field()
#align(center, table(
  columns: 3,
  table.header(align(left)[Attack], [Kerberos], [RADIUS]),
  align(left)[Passive Password Sniffing], [], [],
  align(left)[Offline Brute Force Password Attack], cr, cr,
  align(left)[Active Man-in-the-Middle Attack], [], cr,
  align(left)[Identity Theft on Server], [], [],
  align(left)[CA Compromise], [], cr,
))
#end-note()

#start-note()
=== Authorization

#start-field()
The process of authorization ensures that the requested activity or access to an
object is possible given the rights and privileges assigned to the authenticated
identity

Or in other words: Once a subject is authenticated, access must be authorized

- Just because a subject has been identified and authenticated does not mean
  they have been authorized to perform any function or access all resources
  within the controlled environment

Identification and authentication are all-or-nothing aspects of access control.
This is NOT the case with authorization:

- Authorization has a wide range of variations between all or nothing for each
  object within the environment
#end-note()

#start-note()
==== DAC and NDAC

#start-field()
#diagram(
  node-stroke: none,
  node((3, 0), [Access Control\ (subjects and objects)], name: <ac>),
  node((2, 1), [Nondiscretionary\ (controlled by organization)], name: <nd>),
  node((4, 1), [Discretionary\ (controlled by user)], name: <d>),
  node((2, 2), [Lattice-based], name: <lb>),
  node((1, 3), [Mandatory], name: <m>),
  node((3, 3), [Role-based/Task-based], name: <rb>),
  edge(<ac>, <nd>),
  edge(<ac>, <d>),
  edge(<nd>, <lb>),
  edge(<lb>, <m>),
  edge(<lb>, <rb>),
)
#end-note()

#start-note()
===== Discretionary access control (DAC)

#start-field()
Access controls that are implemented at the judgment or option of the data
owner. Every object has an owner, and the owner can grant or deny access to any
other subjects $->$ The owner (or user) chooses who has access!

- Most flexible and widely used e.g. file system security
- Data owner can modify access control list (ACL)
- Example: User has a hard drive and wants to share it with coworkers. He
  decides who he shares it with.
#end-note()

#start-note()
===== Nondiscretionary access control (NDAC)

#start-field()
Access controls that are implemented by a central authority.

- Example: US-Hospital where access is based on rules and regulations like HIPAA
  (DSG covers that in Switzerland)
#end-note()

#start-note()
====== Lattice-based access control (LBAC)

#start-field()
A variation on mandatory access controls that assigns users a matrix of
authorizations for particular areas of access, incorporating the information
assets of subjects such as users and objects.
#end-note()

- #add-note("Mandatory access control (MAC):", [Use of labels applied to both
    subjects and objects. This means each collection of information is rated,
    and all users are rated to specify the level of access.
    - Example: Information are labelled as top secret $->$ only users that are
      labelled top secret are granted access to this information!
  ])
- #add-note("Role-based (RBAC) / Task-based (TBAC) access control:", [privileges
    are tied to a role or a job (role-based) or to a task or assignment
    (task-based).
    - Example: Project manager has access to corresponding information about his
      project. (role-based)
    - Example: A technician is only allowed into a server room in his planned
      maintenance timeslot (task-based)
  ])

#start-note()
==== Least privilege design principle

#start-field()
Access rights should be limited in scope, time, and function

- "Just enough access" is usually better than broad permanent access

Users and systems should only get the permissions they actually need

- Reduces attack surface and limits damage after account compromise
- Helps prevent misuse of admin accounts and service accounts
- Supports separation of duties and stronger compliance

Requires regular access reviews and removal of unused permissions
#end-note()

#start-note()
=== Auditing

#start-field()
A subject's actions are tracked and recorded

Purpose: Hold the subjects accountable for their actions while authenticated on
a system
#end-note()

#start-note()
=== Accounting

#start-field()
The consumption of resources by a subject is measured, metered, and collected.

Purpose: Provide a record of resource usage for billing, capacity planning, and
trend analysis.
#end-note()

== Establishing accountability and non-repudiation

#add-note(
  "Accountability",
  [
    Accountability means actions can be traced to a specific identity

    - Proving to regulators that your data is secure
    - Link a human to the activities of an identity
    - Requires unique user identities, no shared accounts and trong
      authentication
    - Support your security decisions and their implementation
    - Supports incident investigation, compliance, and trust in transactions
  ],
  format: note-answer,
)

#add-note(
  "Non-repudiation",
  [
    Non-repudiation means a user cannot credibly deny a performed action

    - Logging and audit trails must be complete, accurate, and protected
    - Digital signatures are a key mechanism for non-repudiation
  ],
  format: note-answer,
)

== Common Access Control Attacks

#start-note()
=== Access Aggregation Attacks (passive attack)

#start-field()
- Access aggregation refers to collecting multiple pieces of nonsensitive
  information and aggregating them to learn sensitive information.
- Reconnaissance attacks are access aggregation attacks that combine multiple
  tools to identify multiple elements of a system, such as Internet Protocol
  (IP) addresses, open ports, running services, operating systems.
#end-note()

#start-note()
=== Password Attacks (brute-force attack)

#start-field()

- Online: Attacks against online accounts
- Offline: to steal an account database and then crack the passwords.
#end-note()

#start-note()
=== Dictionary Attack (brute-force attack)

#start-field()

An attempt to discover passwords by using every possible password in a
predefined database or list of common or expected passwords also called a
password-cracking dictionaries

- Dictionary attack databases also include character combinations commonly used
  as passwords, but not found in dictionaries
- Dictionary attacks often scan for one-upped-constructed passwords. A
  one-upped-constructed password is a previously used password, but with one
  character different.
- For example, password1 is one-upped from password, as are Password, 1password,
  and passXword
#end-note()

#start-note()
=== Birthday Attack (brute-force attack)

#start-field()

A birthday attack focuses on finding collisions. Its name comes from a
statistical phenomenon known as the birthday paradox

- The birthday paradox states that if there are 23 people in a room, there is a
  50 percent chance that any two of them will have the same birthday. (This is
  not the same year, but instead the same month and day, such as March 30)
- With February 29 in a leap year, there are only 366 possible days in a year.
  With 367 people in a room, you have a 99.99 percent chance of getting at least
  two people with the same birthdays. Reduce this to only 23 people in the room,
  and you still have a 50 percent chance that any two have the same birthday

You can reduce the success of birthday attacks by using hashing algorithms with
enough bits to make collisions computationally infeasible, and by using salts.
- MD5 is not collision free
- SHA-3 (short for Secure Hash Algorithm version 3) can use as many as 512 bits
  and is considered safe against birthday attacks and collisions – at least for
  now
#end-note()

#start-note()
=== Rainbow Table Attacks

#start-field()

A rainbow table reduces the time by using large databases of precomputed hashes

- It takes a long time to find a password by guessing it, hashing it, and then
  comparing it with a valid password hash

A password cracker can then compare every hash in the rainbow table against the
hash in a stolen password database file

- When using the rainbow table, the password cracker doesn’t spend any time
  guessing and calculating hashes. It simply compares the hashes until it finds
  a match
- This can significantly reduce the time it takes to crack a password
#end-note()

#start-note()
Salting
#start-field()
- adds a unique random value to each password before hashing
- prevents identical passwords from producing identical hash values
#end-note()

#start-note()
=== Sniffer Attacks

#start-field()

A sniffer (also called a packet analyzer or protocol analyzer) is a software
application that captures traffic traveling over the network

- A sniffer attack (also called eavesdropping attack) occurs when an attacker
  uses a sniffer to capture information transmitted over a network

The following techniques can prevent successful sniffing attacks:
- Encrypt all sensitive data (including passwords) sent over a network.
  Attackers cannot easily read encrypted data with a sniffer
- Use onetime passwords (OTP) when encryption is not possible or feasible. OTPs
  prevent the success of sniffing attacks, because they are used only once, also
  see next chapter Kerberos
- Protect network devices with physical security. Controlling physical access to
  routers and switches prevents attackers from installing sniffers on these
  devices
#end-note()

= Cryptography

#deftbl(
  [Plaintext/Cleartext],
  [Before a message is put into a coded form, it is known as a plaintext or
    cleartext],
  [Ciphertext/Cryptogram],
  [The sender of a message uses a cryptographic algorithm to encrypt the
    plaintext and produce a ciphertext or cryptogram],
  [Cipher],
  [
    Encryption algorithm

    An algorithm is a set of rules, usually mathematical, that dictates how
    enciphering and deciphering processes are to take place
  ],
  [Key/Cryptovariable],
  [A key is nothing more than a number (usually a very large binary number)],
  [Key space],
  [
    - Every algorithm has a specific key space. A key space is defined by its
      bit size
    - The key space is the range of numbers from $0$ to $2^n$, where $n$ is the
      bit size of the key
    - A $128$-bit key can have a value from $0$ to $2^128$
  ],
  [One-Way Functions],
  [
    A one-way function is a mathematical operation that easily produces output
    values for each possible combination of inputs but makes it impossible to
    retrieve the input values
    - In practice, it's never been proven that any specific known function is
      truly one way
    - Cryptographers rely on functions that they believe are one way
    - It's always possible that they might be broken by future cryptanalysts
  ],
  [Reversability],
  [Being able to undo the operation of encryption],
  [Nonce],
  [
    The nonce must be a unique number each time it is used
    - Used to make sure that a key is not re-used twice
    - The main feature of a nonce is that it is a number that is only used once
      (nonce)
    - It can be a counter (for example)
    - The nonce is public, whereas the (shared) key is private
  ],
  [Initialization vector (IV)],
  [
    An IV is a random bit string
    - It is the same length as the block size and is XORed ($xor$) with the
      message
    - IVs are used to create unique ciphertext every time the same message is
      encrypted using the same key
  ],
)

#start-note()
== Objectives

#start-field()
- Confidentiality (Privacy)
  - Only authorized persons should read a message, get to know sener/receiver,
    know about the existence of a message
- Integrity
  - Data should be demonstrably unaltered from sender to recipient
- Authentication
  - The identity of an author of a message should be clearly verifiable
- Non-repudiation
  - The sender of a message should not be able to deny authorship or having
    performed an action.
- Procedures do not necessarily have to fulfill every objective
#end-note()

#start-note()
== Kerckhoff's Principles
#end-field()

#deftbl(
  [Security through obscurity],
  [The security of a system or process depends on the confidentiality of its
    secrecy of its functioning],
  [Kerkhoff's Principle\ (Auguste Kerkhoffs, 1883)],
  [The security of an encryption method is based on the secrecy of the key and
    not on the secrecy of the encryption algorithm],
)

#start-field()
A cryptographic system should be secure even if everything about the system,
except the key, is public knowledge
- This principle makes algorithms known and public, allowing anyone to examine
  and test them
- The principle can be summed up as "The enemy knows the system"
- Public exposure may expose weaknesses more quickly, leading to the abandonment
  of insufficiently strong algorithms and quicker adoption of suitable ones
- A large number of cryptographers adhere to this principle, but not all agree
- Some believe that better overall security can be maintained by keeping both
  the algorithm and the key private
#end-note()

== Shannon's Principles

#deftbl(
  [Confusion],
  [
    Confusion occurs when the relationship between the plaintext and the key is
    so complicated that an attacker can’t merely continue altering the plaintext
    and analyzing the resulting ciphertext to determine the key
    - The mapping between input and output is very confusing
    - Substitution of bytes adds confusion
    - Example: S-Box
  ],
  [Diffusion],
  [
    Diffusion occurs when a change in the plaintext results in multiple changes
    spread throughout the ciphertext
    - A small change in the input leads to a big change on the output
    - Permutation of bytes adds diffusion; also known as a transposition
    - Example: P-Box
  ],
)

#start-note()
== Caesar Cipher

#start-field()
One of the earliest known cipher systems was used by Julius Caesar to
communicate with Cicero in Rome while he was conquering Europe

- To encrypt a message, you simply shift each letter of the alphabet three
  places to the right
- The Caesar cipher became known as the ROT3 (or Rotate 3) cipher
- The Caesar cipher is a substitution cipher that is mono-alphabetic
#end-note()

#start-note()
== SP-Network

#start-field()
An SP-Network (Substitution-Permutation Network) is an algorithm that uses
repeated substitution and permutation operations

- Substitution: Replacing bytes with others
- Permutation: Swapping bytes around
- The substitutions and permutations are combined into a round.
- Rounds are then repeated many times
#end-note()

#start-note()
== XOR

#start-field()
#grid(
  columns: (3fr, 1fr),
  [
    XOR is a binary operator between two values that returns true if either
    input or the other is true but not both
    - Extremely useful in cryptography
    - $x$ is deciding whether $y$ will change
    - Applying XOR twice reverses its effect
      - Think of $x$ as encrypting $y$, and then decrypting it again
  ],
  table(
    align: center,
    columns: (1fr, 1fr, 1fr),
    $x$, $y$, $x xor y$,
    $0$, $0$, $0$,
    $0$, $1$, $1$,
    $1$, $0$, $1$,
    $1$, $1$, $0$,
  ),
)
#end-note()

#start-note()
== One-Time PAD (OTP)

#start-field()
#grid(
  columns: (1fr, auto),
  [
    We can design a cipher that uses XOR to encrypt and decrypt a message

    - Use a key that’s the same length as the message
    - XOR each message bit with each key bit

    If you take away the key, there is no way to find the message because there
    is no statical mapping between the input and the output

    But

    - The OTP is not practical
    - A 1 GB file would need a 1 GB key!
    - If you ever reuse a key, the entire cipher is broken
  ],
  ```
  M 01011010 00110101
            ^
  K 01001011 10111001
            =
  C 00010001 10001100
  ```,
)
#end-note()

#start-note()
== Hashing

#start-field()
- A hash function maps data of any size to a fixed-size output in a
  deterministic and hard-to-reverse way
- A 128 bit hash function will return a 128 bit string, regardless of how much
  bits have been hashed in
- Hash functions are used everywhere. Message authentication, integrity,
  passwords etc.
  - For example, SHA-256 can be used to verify data integrity
- A good hash algorithm should perform quickly but it shouldn’t be too quick
  because if it’s too quick, it is easy to break
#end-note()

#start-note()
=== How it works

#start-field()
- Usually hash functions iteratively jumble blocks of a message after another
  - This is a one-way function
  - There is no way to revert back and restore the initial message
- A hash function is kind of like a washing machine for bits
  - The initial hash is usually defined in the spec
  - A new current hash is created every round
  - We loop for every block of the message
- When we run out of message, we use the current hash as the final hash
#end-note()

#start-note()
=== Strong hash functions

#start-field()
The output must be indistinguishable from random noise

- It should look like you have just generated random numbers
- It shouldn’t look like the output is based on the input
- With SHA-256, the output is pretty much undistinguishable from random noise

Bit changes must diffuse through the entire output

- This is called the avalanche effect
- With SHA-256, a small change in the message makes a big change in the hash
#end-note()

#start-note()
=== Important properties

#start-field()
It shall to be quick but not too quick

It shall introduce diffusion

- Most hash functions, even MD5, adhere to that

Given a hash, we can’t reverse it

- Most hash functions, even MD5, adhere to that

Given a message and its hash, we can’t find another message that hashes to the
same thing

- That’s a collision
- That is problematic because we use hashes to verify that things hasn't been
  changed. So finding collision undermines the whole idea
- MD5 is broken in that sense
- shattered.io: two different PDFs that have the exact same SHA-1 hash
#end-note()

#start-note()
=== Current standards in cryptographic hash functions

#start-field()
The current standard is the SHA-2 family with 256-bit and 512-bit variants

SHA-3 is not better or worse than SHA-2

- SHA-3 is a completely different function (Keccak algorithm)
- SHA-3 was designed in case something happens to SHA-2
#end-note()

#start-note()
==== KMAC 128/256

#start-field()
KMAC 128/256 is a new SHA-3 based KECCAK MAC
- standardized in Dec 2016, NIST SP 800-185
- alternative method to SHA-2
- permutation-based hash algorithm (sponge construction)
- very strong resistance to the pre-image
Optimized for parallel processing; efficient on various platforms
#end-note()


#start-note()
=== Hash functions for Password Storage

#start-field()
Hash functions such as SHA-256 are not good to store passwords because there are
too fast

- They are designed to be quick to summarize data
- Vulnerable to brute-force attacks. The attackers hash the passwords and
  compare with the hashes to see if there are any matches

The hashes are iterated to slow them down on purpose

- Argon2 is memory-hard and designed to resist brute-force attacks
- Configurable parameters for memory usage, iterations, and parallelism.
- Slows down attackers – makes massive guessing attempts significantly harder.
- This is exclusively good for login and passwords and not not suitable for
  general-purpose hashing
- It is totally useless for any kind of other hash function usage
#end-note()

#start-note()
=== Comparison of hash families

#start-field()
#table(
  columns: 6,
  table-header(
    [Type/\ Family],
    [Output\ Length],
    [Rounds],
    [Security ],
    [Use /\ Application],
    [Examples /\ Libraries],
  ),
  [MD5],
  [128-bit],
  [4],
  [128-bit, fast, insecure],
  [Legacy systems, checksums],

  [OpenSSL, hashlib\ (Python)],
  [SHA-1],
  [160],
  [80],
  [160-bit, insecure],
  [Legacy signatures, integrity checks],

  [OpenSSL, hashlib\ (Python)],
  [SHA-2],
  [224, 256,\ 384, 512],
  [64, 80],
  [Secure, widely used],
  [Digital signatures, certificates],

  [OpenSSL, hashlib\ (Python)],
  [SHA-3\ (Keccak)],
  [224, 256,\ 384, 512],
  [24],
  [Resistant to certain attacks, flexible],
  [Modern crypto applications],

  [hashlib (Python\ ≥3.6)],
  [bcrypt],
  [184-bit],
  [],
  [Adaptive, salted, GPU- resistant ],
  [Password storage],

  [bcrypt (Python )],

  [Argon2 ],
  [256],
  [],
  [Winner of Password Hashing Competition, highly secure, configurable],
  [Password storage, key derivation function],
  [argon2-cffi\ (Python)],

  [PBKDF2],

  [Varies],
  [],
  [Iterative, widely supported, configurable iterations],
  [Password storage],
  [hashlib.pbkdf2\_\ hmac (Python )],
)
#end-note()

#start-note()
=== Where are hashes used?

#start-field()
Hashing lets us ensure that a message hasn’t been altered

+ Digital signatures
+ Message Authentication Codes (MAC)
#end-note()

#start-note()
=== HMAC

#start-field()
- MAC approaches may have issues due to the structure of common hash functions
  like SHA-256
  - MAC with SHA-1 and SHA-2: possibility of length extension attack
- Hash based MAC (HMAC) is a standardized form and the most common approach, it
  splits a key in two and hashes twice
  - We hash two times to be safer.
  - We split the key into two and we hash twice with each key
  - Then not vulnerable to length extension attack
#end-note()

#start-note()
== Symmetric cryptography

#start-field()
Symmetric key algorithms rely on a shared secret key that is distributed to all
members who participate in the communications.

- This key is used by all parties to both encrypt and decrypt messages
- The sender encrypts with the shared secret key and the receiver decrypts with
  it.
- When large-sized keys are used, symmetric encryption is very difficult to
  break.

It provides for the security service of confidentiality
#end-note()

#start-note()
=== Stream ciphers

#start-field()
We can approximate a one-time pad by generating an infinite pseudo-random
keystream
- Stream ciphers work on messages of any length
- The nonce guarantees that each keystream is unique, even if the same key is
  reused
#end-note()

#start-note()
==== Pros and cons

#start-field()
#table(
  columns: 2,
  table-header([Pros], [Cons]),
  [Encryption of long continuous streams, possibly of unknown length

    Extremely fast with a low memory footprint, ideal for low-power devices

    If designed well, it can seek to any location in the stream],

  [The keystream must appear statistically random

    You must never reuse a key + nonce

    Stream ciphers do not protect the ciphertext (= no guaranteed integrity)],
)
#end-note()

#start-note()
=== Block ciphers

#start-field()
Block ciphers take an input of a fixed size and return an output of the same
size

- Block ciphers attempt to hide the transformation from message to ciphertext
  through confusion and diffusion
- Most block ciphers are SP-Networks

The Advanced Encryption Standard (AES) is an SP-Network

- Almost everything uses AES
- There are others (e.g. Feistel Ciphers)
#end-note()

#let s-p-diag = (
  a,
  b,
  yoff: 0,
  xoff: 0,
  s: true,
  sa: true,
  sb: true,
  rev: false,
) => (
  node(
    enclose: a.enumerate().map(((i, _)) => (i + xoff, 1 + yoff)),
    fill: if s { colors.purple } else { colors.purple.transparentize(60%) },
    height: if s { 2em } else { 5em },
  ),
  ..(
    if sa { a.enumerate().map(((i, n)) => node((i + xoff, yoff), $#n$)) } else {
      ()
    }
  ),
  ..(
    if sb {
      b.enumerate().map(((i, n)) => node((i + xoff, 2 + yoff), $#n$))
    } else { () }
  ),
  ..(
    {
      let eh = (7, 5, 0, 4, 1, 2, 3, 6)
      (
        if s { a.enumerate().zip(b.enumerate()) } else if rev {
          eh
            .zip(a)
            .zip(
              b.enumerate(),
            )
        } else {
          a
            .enumerate()
            .zip(
              eh.zip(b),
            )
        }
      ).map((((fi, f), (ti, t))) => edge(
        (fi + xoff, yoff),
        ..(
          if s { () } else {
            (
              (fi + xoff, 0.5 + yoff),
              (ti + xoff, 1.5 + yoff),
            )
          }
        ),
        (ti + xoff, 2 + yoff),
        "-",
        stroke: colors.purple,
      ))
    }
  ),
)

#start-note()
==== S-Box
#start-field()
Provides Confusion

#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  [Visualization], [Lookup Table],
  diagram(
    node-stroke: none,
    node((-1, 0), [in $12_10$]),
    node((-1, 2), [out $5_10$]),
    ..s-p-diag(
      (1, 1, 0, 0),
      (0, 1, 0, 1),
    ),
  ),
  table(
    columns: 7,
    stroke: 1pt + colors.fg,
    table-header([in], $0$, $1$, $...$, $12$, $...$, $15$),
    emph[out],
    $6$,
    $13$,
    $...$,
    $5$,
    $...$,

    $4$,
  ),
)
#end-note()

#start-note()
==== P-Box
#start-field()
Provides Diffusion

#align(center, diagram(
  node-stroke: none,
  node((-1, 0), [in $171_10$]),
  node((-1, 2), [out $211_10$]),

  ..s-p-diag(
    (1, 0, 1, 0, 1, 0, 1, 1),
    (1, 1, 0, 1, 0, 0, 1, 1),
    s: false,
  ),
))
#end-note()

#start-note()
==== Encryption and decryption in a basic SP-Network

#start-field()
Combines S-Box and P-Box

#align(center, diagram(
  node-stroke: none,
  node((-1, 0), [in $103_10$]),
  node((-1, 4), [encrypted $19_10$]),
  node((-1, 8), [decrypted $103_10$]),
  node((-1, 1), [$-> "substitution"$]),
  node((-1, 7), [$-> "substitution"^(-1)$]),
  node((-1, 3), [$-> "diffusion"$]),
  node((-1, 5), [$-> "diffusion"^(-1)$]),

  ..s-p-diag(
    (0, 1, 1, 0),
    (1, 0, 0, 0),
  ),
  ..s-p-diag(
    xoff: 4,
    (0, 1, 1, 1),
    (0, 0, 1, 1),
  ),

  ..s-p-diag(
    yoff: 2,
    sa: false,
    (0, 1, 1, 0, 0, 1, 1, 1),
    (0, 0, 0, 1, 0, 0, 1, 1),
    s: false,
  ),

  ..s-p-diag(
    yoff: 4,
    sa: false,
    sb: false,
    (0, 0, 0, 1, 0, 0, 1, 1),
    (0, 1, 1, 0, 0, 1, 1, 1),
    s: false,
    rev: true,
  ),

  ..s-p-diag(
    yoff: 6,
    (1, 0, 0, 0),
    (0, 1, 1, 0),
  ),
  ..s-p-diag(
    yoff: 6,
    xoff: 4,
    (0, 0, 1, 1),
    (0, 1, 1, 1),
  ),
))
#end-note()

#start-note()
==== Advanced Encryption Standard (AES)

#start-field()
- A standard built around the Rijndael algorithm
  - Superseded DES as a standard in 2002
- SP-Network with a 128-bit block size
  - Key length of 128, 192 or 256-bits
  - 10, 12 or 14 rounds
  - Each Round:
    - SubBytes
    - ShiftRows
    - MixColumns
    - Key Addition
#end-note()

_Round Structure_

#grid(
  columns: (1fr, 2fr),
  align: center + horizon,
  grid(
    columns: (2em, 2em, 2em, 2em),
    rows: (2em, 2em, 2em, 2em),
    gutter: 0pt,
    stroke: 1pt + colors.fg,
    inset: .5em,
    $a_(0,0)$, $a_(0,1)$, $a_(0,2)$, $a_(0,3)$,
    $a_(1,0)$, $a_(1,1)$, $a_(1,2)$, $a_(1,3)$,
    $a_(2,0)$, $a_(2,1)$, $a_(2,2)$, $a_(2,3)$,
    $a_(3,0)$, $a_(3,1)$, $a_(3,2)$, $a_(3,3)$,
  ),
  diagram(
    node-stroke: none,
    node((1, 0), [Plaintext]),
    edge("-|>"),
    node((1, 1), text(size: 2em, $xor$), name: <xor>),
    edge("-|>"),
    node((1, 2), [SubBytes], name: <sb>),
    edge("-|>"),
    node((1, 3), [ShiftRows], name: <sr>),
    edge("-|>"),
    node((1, 4), [MixColumns], name: <mc>),
    edge(<mc>, (0, 4), (0, 1), <xor>, "-|>"),
    node((-1, 2), [X Rounds]),
    node((1.75, 1), [XOR with key $(k_0,k_1,k_2,...)$]),
    node(enclose: (<sb>,), shape: fletcher.shapes.brace.with(dir: right)),
    node((1.75, 2), [Confusion]),
    node(enclose: (<sr>, <mc>), shape: fletcher.shapes.brace.with(dir: right)),
    node((1.75, 3.5), [Diffusion]),
  ),
)

#let bs = (
  (
    $b_(00)$,
    $b_(01)$,
    $b_(02)$,
    $b_(03)$,
    $b_(04)$,
    $b_(05)$,
    $b_(06)$,
    $b_(07)$,
    $b_(08)$,
    $b_(09)$,
    $b_(10)$,
    $b_(11)$,
    $b_(12)$,
    $b_(13)$,
    $b_(14)$,
    $b_(15)$,
  )
    .enumerate()
    .map(((i, n)) => text(
      fill: color-cycle.at(int(i / 4)).lighten(calc.rem(i, 4) * 20%),
      weight: calc.rem(i, 4) * 300,
      n,
    ))
)
#let bs2 = range(4).map(y => range(4).map(x => bs.at(x * 4 + y))).join()
#let wrap = (i, f, t) => if i < f { t - f + i } else if i > t {
  f + i - t
} else { i }
#let sbs = (
  range(4)
    .map(y => range(4).map(x => {
      let r = x * 4
      let i = r + y
      bs2.at(wrap(i - 4 + x, r, r + 4))
    }))
    .join()
)
#let sbs2 = range(4).map(y => range(4).map(x => sbs.at(x * 4 + y))).join()
#let bg = grid.with(
  align: center + horizon,
  columns: range(16).map(_ => 3em),
  rows: (3em,),
  gutter: 0pt,
  stroke: 1pt + colors.fg,
  inset: .5em,
)
#let bg2 = grid.with(
  align: center + horizon,
  columns: (3em, 3em, 3em, 3em),
  rows: (3em, 3em, 3em, 3em),
  gutter: 0pt,
  stroke: 1pt + colors.fg,
  inset: .5em,
)

#start-note()
_Key addition to a Block / XOR _

#start-field()
128 bits block after XOR with the extended key

#bg(..bs)
#bg2(..bs2)
#end-note()

#start-note()
_SubBytes_

#start-field()
It is a lookup table, there is no fixed point (byte 15 doesn't end up byte 15)

There is no opposite bit flap (10101010 didn't become 01010101)

#bg(..bs.map(b => $S(#b)$))
#bg2(..bs2.map(b => $S(#b)$))
#end-note()

#start-note()
_ShiftRows_

#start-field()
#bg(..sbs.map(b => $S(#b)$))
#grid(
  columns: 2,
  bg2(..sbs2.map(b => $S(#b)$)),
  grid(
    align: center + horizon,
    rows: (3em, 3em, 3em, 3em),
    gutter: 0pt,
    inset: .5em,
    [No changes],
    [1 to the left],
    [2 to the left],
    [3 to the left],
  ),
)
#end-note()

#start-note()
_MixColumns_

#start-field()
MixColumns is done using a matrix multiplication

- Add operation is an XOR
- Multiplication operation is a multiplication within that finite field (modular
  polynomial)

$
  mat(2, 3, 1, 1; 1, 2, 3, 1; 1, 1, 2, 3; 3, 1, 1, 2) dot vec(b_(00), b_(05), b_(10), b_(15)) = vec(
    & 2b_00 && + 3b_05 && + b_10 && + b_15,
    & b_00 && + 2b_05 && + 3b_10 && + b_15,
    & b_00 && + b_05 && + 2b_10 && + 3b_15,
    & 3b_00 && + b_05 && + b_10 && + 2b_15,
  )
$
#end-note()

#start-note()
==== Modes of operation for block ciphers
#start-field()
- Realistically, messages of exactly 128-bits are pretty unlikely
  - We need some mechanism to encrypt messages that are longer or shorter
- A mode of operation is the combination of multiple instances of block
  encryption into a usable protocol
- There are several modes of operations, in this lecture we only cover the
  following:
  - Electronic Code Book (ECB)
  - Cipher Block Chaining (CBC)
  - Counter Mode (CTR)
#end-note()

#start-note()
==== Electronic Code Block (ECB)
#start-field()
- Just encrypt each block one after another with same key
- Weak to redundant data divulging patterns
- Electronic codebook is not recommended!

#let ecb-diag(n, d: auto, e: true) = {
  let d = if d == auto { n } else { d }
  (
    node((n + 1, 0), if e { $P_#d$ } else { $C_#d$ }),
    edge("->"),
    node((n + 1, 1), if e [Encrypt] else [Decrypt]),
    edge("->"),
    node((n + 1, 2), if e { $C_#d$ } else { $P_#d$ }),

    edge((n, 1), (n + 1, 1), label: [K], "->", label-pos: 0%),
  )
}
#diagram(
  spacing: (2em, 1em),
  node((-1, 0), [_Encryption_], stroke: none),
  ..ecb-diag(1),
  ..ecb-diag(3, d: 2),
  node((5, 1), $...$, stroke: none),
  ..ecb-diag(6, d: "n"),
)
#line(length: 100%, stroke: colors.darkblue)
#diagram(
  spacing: (2em, 1em),
  node((-1, 0), [_Decryption_], stroke: none),
  ..ecb-diag(1, e: false),
  ..ecb-diag(3, d: 2, e: false),
  node((5, 1), $...$, stroke: none),
  ..ecb-diag(6, d: "n", e: false),
)
#end-note()

#start-note()
==== Cipher Block Chaining (CBC)
#start-field()
- XOR the IV with the first input, then XOR the output of each cipher block with
  the next input
  - Not parallelizable
  - It is better than ECB but not perfect

#let cbc-diag(n, d: auto, e: true) = {
  let d = if d == auto { n } else { d }
  let (xn, en) = if e { (1, 2) } else { (2, 1) }
  let (xe, ee) = if e { (3, 1) } else { (0, 2) }
  (
    node((n + 1, 0), if e { $P_#d$ } else { $C_#d$ }),
    edge((n + 1, 0), (n + 1, 1), "->"),
    node((n + 1, xn), text(size: 2em)[$xor$], stroke: none),
    edge((n + 1, 1), (n + 1, 2), "->"),
    node((n + 1, en), if e [Encrypt] else [Decrypt]),
    edge((n + 1, 2), (n + 1, 3), "->"),
    node((n + 1, 3), if e { $C_#d$ } else { $P_#d$ }),

    edge((n, 1), (n + 1, 1), "->"),
    edge((n, en), (n + 1, en), label: [K], "->", label-pos: 0%),
    (
      if n == 1 {
        edge((n, xn), (n + 1, xn), "->", label: [IV], label-pos: 0%)
      } else {
        edge((n - 2, xe), (n - 1, xe), (n - 1, ee), (n + 1, ee), "->")
      }
    ),
    (
      if n == 4 {
        edge((n + 1, xe), (n + 2, xe), (n + 2, ee), (n + 3, ee), "->")
      }
    ),
  )
}
#diagram(
  spacing: (2em, 1em),
  node((-1, 0), [_Encryption_], stroke: none),
  ..cbc-diag(1),
  ..cbc-diag(4, d: 2),
  node((7, 3), $...$, stroke: none),
  ..cbc-diag(9, d: "n"),
)
#line(length: 100%, stroke: colors.darkblue)
#diagram(
  spacing: (2em, 1em),
  node((-1, 0), [_Decryption_], stroke: none),
  ..cbc-diag(1, e: false),
  ..cbc-diag(4, d: 2, e: false),
  node((7, 2), $...$, stroke: none),
  ..cbc-diag(9, d: "n", e: false),
)
#end-note()

#start-note()
==== Counter Mode (CTR)
#start-field()
- Encrypting a counter to produce a stream cipher
  - Pretty good - can also be parallelized!
  - Convert a block cipher into a stream
- We don't encrypt the message
  - We encrypt a number and use the random number that comes out to XOR the
    message
- Standard mode for all type of encryption cipher (AES)

#let ctr-diag(n, d: auto, e: true) = {
  let d = if d == auto { n } else { d }
  (
    node((n + 1, 0), [Counter #d]),
    edge("->"),
    node((n + 1, 1), if e [Encrypt] else [Decrypt]),
    edge("->"),
    node((n + 1, 2), text(size: 2em)[$xor$], stroke: none),
    edge("->"),
    node((n + 1, 3), if e { $C_#d$ } else { $P_#d$ }),
    node((n, 2), if e { $P_#d$ } else { $C_#d$ }),

    edge((n, 2), (n + 1, 2), "->"),
    edge((n, 1), (n + 1, 1), label: [K], "->", label-pos: 0%),
  )
}
#diagram(
  node((-1, 0), [_Encryption_], stroke: none),
  ..ctr-diag(1),
  ..ctr-diag(3, d: 2),
  node((5, 2), $...$, stroke: none),
  ..ctr-diag(6, d: "n"),
)
#line(length: 100%, stroke: colors.darkblue)
#diagram(
  node((-1, 0), [_Decryption_], stroke: none),
  ..ctr-diag(1, e: false),
  ..ctr-diag(3, d: 2, e: false),
  node((5, 2), $...$, stroke: none),
  ..ctr-diag(6, d: "n", e: false),
)
#end-note()

=== Remarks

Key distribution

- #add-answer-note("What is the requirement for key distribution?", [Parties
    must have a secure method of exchanging the secret key before establishing
    communications with a symmetric key protocol])

#add-answer-note("Does symmetric key cryptography implement non-repudiation?", [
  Symmetric key cryptography does not implement non-repudiation

  - Because any communicating party can encrypt and decrypt messages with the
    shared secret key, there is no way to prove where a given message originated
])

#add-answer-note(
  "Does symmetric key cryptography implement message integrity?",
  [
    Symmetric key cryptography does not implement message integrity
  ],
)

#add-answer-note("What is the major strength of symmetric key cryptography?", [
  The major strength of symmetric key cryptography is the great speed at which
  it can operate

  - Symmetric key encryption is very fast, often 1'000 to 10'000 times faster
    than asymmetric algorithms
  - Lots of the processor have an AES instruction set
  - Alternative to AES: the Chacha20 cipher
])

#start-note()
=== RSA

#start-field()
+ Choose two prime numbers $p,q$
+ Calculate $n = p dot q$
+ Calculate $phi(n)=(p-1)(q-1)$
+ Choose $a,b$, so that $a dot b equiv 1 mod phi(n)$
+ Forget $p,q,phi(p dot q)$

Public key is now $n,b$, private key is $n,a$ \

- Encrypt: $z = c^a mod n$ \
- Decrypt: $c = z^b mod n <=> c^a^b mod n$ \
#end-note()

#start-note()
=== Diffie-Hellman key exchange

#start-field()
#{
  let anode = node.with(fill: colors-l.yellow.lighten(30%))
  let bnode = node.with(fill: colors-l.comment.lighten(30%))
  let pnode = node.with(fill: colors-l.purple.lighten(30%))
  let edge = edge.with(marks: "-|>")
  diagram(
    node-shape: fletcher.shapes.pill,
    spacing: (4em, 1em),

    node(
      width: 17em,
      (-.85, 0),
      align(left, [1. Agree on #tp[*public parameters*]]),
      stroke: none,
    ),
    node(
      width: 17em,
      (-.85, 1),
      align(left, [2. Combine #tr[*private key*]\ with #tp[*the parameters*]]),
      stroke: none,
    ),
    node(
      width: 17em,
      (-.85, 2),
      align(left, [
        3. Send resulting #tg[*public\ keys*] to each other
      ]),
      stroke: none,
    ),
    node(
      width: 17em,
      (-.85, 3),
      align(left, [
        4. Combine other's #tg[*pubkey*] with\ #tr[*private key*] to get shared
          #td[*secret*]
      ]),
      stroke: none,
    ),

    anode((0, -1), [Alice], stroke: none, shape: fletcher.shapes.rect),
    anode((0, 0), strong(tr($a=4$)), name: <a1>),
    anode(
      (0, 2),
      strong($#tg($a_"pub"$)=#tp($5$)^#tr($4$) mod #tp($23$) = #tg($4$)$),
      name: <a2>,
    ),
    anode(
      (0, 3),
      strong(
        $#td[$s$] = #place(dy: -.4em, dx: -.25em, box(radius: 50%, inset: .75em, fill: colors-l.comment.lighten(30%)))#tg($10$)^#tr($4$) mod #tp($23$) = #td[$18$]$,
      ),
      name: <a3>,
    ),

    pnode((.5, -1), [Public], stroke: none, shape: fletcher.shapes.rect),
    pnode((.5, 1), strong(tp($p=23,g=5$)), name: <p>),

    bnode((1, -1), [Bob], stroke: none, shape: fletcher.shapes.rect),
    bnode((1, 0), strong(tr($b=3$)), name: <b1>),
    bnode(
      (1, 2),
      strong($#tg($b_"pub"$)=#tp($5$)^#tr($3$) mod #tp($23$) = #tg($10$)$),
      name: <b2>,
    ),
    bnode(
      (1, 3),
      strong(
        $#td[$s$] = #place(dy: -.4em, dx: -.5em, box(radius: 50%, inset: .75em, fill: colors-l.yellow.lighten(30%)))#tg($4$)^#tr($3$) mod #tp($23$) = #td[$18$]$,
      ),
      name: <b3>,
    ),

    edge(<a1>, <p>, label: [1]),
    edge(<p>, <a2>, label: [2]),
    edge(<a1>, <a3>, label: [4], bend: -80deg),
    edge(<a1>, <a2>, label: [2]),
    edge(<a2>, <b3>, label: [3], label-pos: 30%),

    edge(<b1>, <p>, label: [1]),
    edge(<p>, <b2>, label: [2]),
    edge(<b1>, <b3>, label: [4], bend: 80deg),
    edge(<b1>, <b2>, label: [2]),
    edge(<b2>, <a3>, label: [3], label-pos: 30%),
  )
}

Elliptic-Curve Diffie Hellman (ECDH) is becoming the standard nowadays due to
shorter keys.
#end-note()
