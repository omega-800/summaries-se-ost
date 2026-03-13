#import "@preview/cetz:0.3.4"
#import "../lib.typ": *

#show: project.with(
  module: "CySec",
  name: "Cyber Security Foundations",
  semester: "FS26",
  language: "en",
)

= Information security

#deftbl(
  [Information],
  [An organization's data that has been processed, organized, or structured in a way that gives it meaning and value to an organization or individual.],
  [Information security],
  [Protection of the integrity, confidentiality and availability of information data whether in storage, transit or processing.],
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
  [an event or action with the potential to cause harm by exploiting a vulnerability],
  [risk],
  [the likelihood of a threat exploiting a vulnerability and the potential harm that could cause],
  [control],
  [
    a measure designed to reduce the potential risk of an attack
    - Can be achieved through training employees, enforcing policies or implementing technology
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

== Types of information

- Personal information
- Business information
- Financial information
- Intellectual property
  - Copyright
  - Trademarks
  - Patents
  - Trade secrets
- System information

== How can information be attacked

- In storage
  - Data that is stored on a server or in a database short-term or long-term.
- In transit
  - Data that is currently being transported from one place to another.
- In use
  - Data that is currently being processed by a service or another entity.

== Components of an Information System (IS)

- Software
- Hardware
- Data
- People
- Procedures
- Networks

== Balancing security and system usability

- Obtaining perfect information security is impossible.
- Security needs to protect the system without slowing people down.
- Too much security can lead to workarounds.
  - Example: If strong passwords are enforced, people might start writing them down on sticky notes.
- Too much convenience exposes the system to unnecessary risks.
- It's all about finding that sweet spot between security and usability.
  - Example Solution: Employees must use multi-factor authentication. This way, they are free to use a less secure password without compromising the overall security.
- An even better, continuously review policies and involve users to find the best solution.

== Implementation of information security

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
  [Bottom-Up], [Top-Down],
  [
    - Initiated by an organization’s technical staff (system engineers, admins, etc.).
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

== CIA Triad

The CIA triad is a foundational information-security model stating that systems should protect:
- *Confidentiality* - Keeping information secret <confidentiality>
- *Integrity* - Keeping information correct and unaltered <integrity>
- *Availability* - Ensuring information and systems remain accessible <availability>

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  [], [Confidentiality], [Integrity], [Availability],
  [Goal],
  [Prevent or minimize unauthorized access to information],
  [Protecting the reliability and correctness of information.],
  [Ensuring that subjects have timely and uninterrupted access to information.],

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

== Non-Repudiation and Accountability

Example of security controls through which non-repudiation can be established: Digital certificates, session identifiers, transaction logs, etc.

=== Non-Repudiation <non-repudiation>

- Ensures that the subject of an activity or who caused an event cannot deny having performed an action or cannot deny that the event occurred.
- Non-Repudiation prevents a subject from claiming not to have sent a message, not to have performed an action, or not to have been the cause of an event.

=== Accountability

- Being responsible or obligated for actions and results.
- Non-Repudiation is an essential part of accountability. A suspect cannot be held accountable if they can repudiate the claim against them.

== STRIDE Model

A structured model developed by Microsoft used in cybersecurity to identify and categorize threats to systems by looking at how they can be attacked.

#todo("Authenticity")
#deftbl(
  [S(poofing)],
  [Pretending to be someone else. (see #link(<confidentiality>, "Authenticity"))],
  [T(ampering)],
  [Unauthorized data modification or altering. (see #link(<integrity>, "Integrity"))],
  [R(epudiation)],
  [Denying actions without proof. (see #link(<non-repudiation>, "Non-Repudiation"))],
  [I(nformation disclosure)],
  [Exposing sensitive information. (see #link(<confidentiality>, "Confidentiality"))],
  [D(enial of service)],
  [Making systems or services unavailable. (see #link(<availability>, "Availability"))],
  [E(levation of privilege)],
  [Gaining unauthorized rights or privileges. (see #link(<authorization>, "Authorization"))],
)

== McCumber Cube

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

= Threat categorization

#deftbl(
  link(<social-engineering>, [Social Engineering]),
  [Manipulating people to reveal confidential information.],
  link(<software-attacks>, [Software Attacks]),
  [Exploiting vulnerabilities in software to gain access to a system or steal data.],
  link(<denial-of-service>, [Denial of Service]),
  [Overloading one or multiple systems to make it unavailable.],
  link(<webapp-attacks>, [Web Application Attacks]),
  [Exploiting vulnerabilities in websites or servers hosting websites.],
  link(<password-attacks>, [Password /\ Authentication Attacks]),
  [Attempting to bypass or compromise login systems to gain unauthorized access.],
  link(<physical-threats>, [Physical Attacks]),
  [Bypassing technical controls by accessing physical infrastructure directly.],
)

== Social engineering <social-engineering>

The psychological manipulation of individuals to trick them into revealing confidential information or performing actions that can compromise security.

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

== Software attacks <software-attacks>

Attacks involving malicious code or malware designed to damage systems, steal sensitive data, or gain unauthorized access to systems or services.

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

== Denial of service <denial-of-service>

Attacks aims at making a system or service unavailable by overwhelming it with excessive traffic or requests.

#deftbl(
  [DoS],
  [Single source denial of service attacks.],
  [DDoS],
  [Denial-of-service attacks performed by multiple attackers or attacking devices.],
  [Botnet],
  [A network of compromised computers and other devices controlled by an attacker and used to together to flood a target with excessive traffic.],
  [SYN-Flood Attack],
  [Sending many connection requests without completing them.],
  [Reflection Attack],
  [Attacker sends requests to a service and spoofs the victim’s IP making the service send (many) replies to the victim instead of back to the attacker.],
)

== Web application attacks <webapp-attacks>

Exploits vulnerabilities in web applications to steal data, manipulate content, or gain unauthorized access.

#deftbl(
  [SQL Injection],
  [An attacker inserts malicious SQL commands into an input to manipulate a database and access, modify, or delete data.],
  [Cross-Site Scripting (XSS)],
  [An attacker injects malicious scripts into a website that execute in other users’ browsers to steal sensitive data.],
  [Cross-Site Request\ Forgery (CSRF)],
  [An attacker tricks a logged-in user’s browser into sending unauthorized requests to a web application on their behalf.],
  [Broken Authentication],
  [Weak authentication mechanisms allow attackers to compromise passwords, sessions, or identities to gain unauthorized access.],
)

== Password / Authentication attacks <password-attacks>

Attacks that attempt to bypass or compromise login systems to gain unauthorized access to a system or service.

#deftbl(
  [Rainbow Table Attacks],
  [Attackers using precomputed hash lookup tables to reverse weakly hashed passwords back into plaintext.],
  [Password Spraying],
  [Attackers trying a few common password like “password” across many accounts to avoid lockouts or timeouts.],
  [Credential Stuffing],
  [Attackers using leaked usernames and passwords from previous breaches to attempt logins on other services.],
  [Brute Force Attack],
  [Attackers repeatedly try many username and password combinations until they successfully gain access to an account.],
)

== Physical threats <physical-threats>

Threats or attacks that affect the physical infrastructure supporting information systems, usually bypassing technical controls overall.

#deftbl(
  [Theft of devices],
  [Attackers physically steal hardware to gain direct access to stored data, credential, internal systems, or other sensitive data.],
  [Hardware tampering],
  [An attacker modifies or implants malicious components in physical equipment to intercept data, bypass security, or disrupt operations.],
  [Power disruption],
  [Attackers interrupt or manipulate power supply to shut down or destabilize critical systems or services impacting availability and business continuity.],
  [Environmental damage],
  [Natural or deliberate environmental events that damage infrastructure, causing data loss, downtime, or destruction of critical systems (e.g., earthquake, fire).],
)

= Information Security Management

== Information Security Governance

The system by which an organization directs and controls its information security strategy to ensure that it supports business objectives, manages risk appropriately, and complies with legal and other regulatory requirements.

Strategic Direction

- Defining security objectives aligned with business goals.

Leadership and Accountability

- Having clear roles and responsibilities for security decisions.

Risk Management

- Defining risks and ensuring they are identified and addressed appropriately.

Regulatory Compliance

- Ensuring adherence to laws and regulations (e.g. NIS2, HIPAA, CRA)

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

== Information Security Management System (ISMS)

A structured framework used to systematically manage and protect an organization’s assets through various policies, processes and controls

Security governance defines *what* an organization wants to achieve. An ISMS defines *how* the organization wants to manage it.

Enterprise Information Security Policy (EISP)

- The information security policy that sets the strategic direction and scope for all an organization's security efforts.
Risk Management Process
- Definition of processes to identify assets, analyze threats and evaluate risk.
Security Awareness and Training
- Educational programs to ensure employees understand their security responsibilities.
Monitoring, Measurement and Audits
- Ongoing evaluation of control effectiveness and ISMS performance.

= Policy

A high-level, management-approved rule that defines mandatory organizational behavior and translates external laws and regulations into enforceable internal requirements.

#deftbl(
  [policy],
  [instructions that dictate certain behavior within an organization.],
  [guidelines],
  [non-mandatory recommendations employees may use as a reference.],
  [procedures],
  [step-by-step instructions designed to assist employees in following policies.],
  [practices],
  [examples of actions that illustrate compliance with policies.],
  [standard],
  [a detailed statement of what must be done to comply with a policy.],
  [de jure standard],
  [a standard that has been formally evaluated and approved by a formal standards organization],
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

_What does a policy do?_
Establishes authority, accountability, and responsibilities for protecting information assets. Provides the foundation for standards, procedures and guidelines.

_Who is responsible for policies?_
Policies are created and approved by senior management, ensuring organizational commitment. Management is responsible for enforcement while employees and users are responsible for compliance.

_How is a policy enforced?_
By clearly communicating it to all relevant parties, integrating it into standards and procedures, monitoring compliance through audits and oversight, and applying defined disciplinary measures when violations occur.

- Cyber Resilience Act (EU)
  - Requires secure-by-design digital products and vulnerability management (starting December 2027).
- Health Insurance Portability and Accountability Act (U.S.)
  - Requires administrative, technical, and physical safeguards for protecting patient health data from disclosure.
- NIS2 Directive (EU)
  - Mandates cybersecurity risk management and incident reporting for critical and important entities.
- Local Laws
  - Many regions have their own data protection or breach notification laws in additional to national or EU regulations.

== Designing effective policies

+ Development
  - Policies must align with organizational goals, business risks and legal requirements.
+ Distribution
  - Policies must be distributed to all affected entities in a timely manner.
+ Comprehension
  - Policies must be readable for, available to and read by all affected entities.
+ Compliance
  - Policies must be formally agreed to by act or affirmation.
+ Enforcement
  - Policies must be uniformly applied to all affected entities.
+ Review
  - Policies must be reviewed regularly in a changing environment.

== Enterprise Information Security Policy (EISP)

The high-level information security policy that sets the strategic direction, scope and tone for all an organization's security efforts and policies.

- Guidance for the development, implementation and management of the security program.
- Sets the requirements that must be met by the information security blueprint.
- Defines the purpose, scope, constraints and applicability of the security program.
- Assigns responsibilities for the various areas of information security.
- Addresses legal compliance.

=== Elements of an EISP

Although the content of EISP documents varies among organizations, most EISP documents should include the following elements.

- Statement of Purpose
  - Statement of intent that defines the scope, objectives, and purpose of the enterprise information security policy and establishes its role as the foundation for all supporting security documents.
- Information Security Elements
  - Definition of information security that outlines the core principles and concepts, including confidentiality, integrity, and availability, guiding the organization’s security efforts.
- Need for Information Security
  - Definition of the importance of information security within an organization and its legal and ethical responsibility to protect information about customers, employees, and markets.
- Information Security Responsibilities and Roles
  - Description of the organizational structure that supports information security, including defined roles and responsibilities for management, employees, and users, as well as responsibility for maintaining the policy itself.

== Issue-Specific Security Policy

An organizational policy that provides detailed, targeted guidance to instruct members of an organization in the use of a specific resource.

- Supports the EISP by translating it into an issue-specific guidance.
- Establishes rules for access, monitoring, and protection of the resource.
- Defines acceptable and unacceptable use of the specified technology or resource.
- Assigns responsibilities and accountability to users, administrators, and management.


= Risk analysis

The process of identifying assets, threats, and vulnerabilities, and evaluating the likelihood and impact of potential adverse events to determine the level of risk.

#{
  // let edge = edge.with(corner: left)
  diagram(
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
}

== Identifying Assets

#deftbl(
  [Asset],
  [Any resource that has some kind of value to an organization and therefore requires protection.],
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

== Classifying Assets

The process of assigning every asset to a class based on their value, sensitivity and impact if compromised

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

== Identifying Threats

A potential event, actor, or action that could exploit a vulnerability and cause harm to an asset.

Examples: Power outage, insider threat, vishing attack

== Security Controls

#todo("belongs into information security management")

Measures to reduce risk by detecting, preventing, responding to, or mitigating threats to organizational assets.

=== Types

#deftbl(
  [Administrative /\ Management Controls],
  [Policies, procedures, security training, security governance, etc.],
  [Technical / Logical Controls],
  [Firewalls, encryption, access control systems, system hardening, etc.],
  [Physical Controls],
  [Physical locks, surveillance cameras, secure access badges, turnstiles, etc.],
)

=== By Function

#deftbl(
  [Preventive Controls],
  [Stop incidents before they occur.\ e.g., Firewalls, access control, encryption, etc.],
  [Detective Controls],
  [Identify incidents when they occur.\ e.g., Intrusion detection, log monitoring, SIEM, CCTV, etc.],
  [Corrective Controls],
  [Limit damage and restore systems after an incident.\ e.g., Backups, system restore, incident response, etc.],
  [Deterrent Controls],
  [Discourage malicious behavior.\ e.g., Warning banners, monitoring notices, disciplinary policies, etc.],
  [Compensating Controls],
  [Reduce risk when a primary control cannot be implemented.\ e.g., Network isolation, layered security, alternative safeguards, etc.],
)

== Business Continuity Management

Ensures that critical business functions can continue during and after incidents or disruptions such as cyberattacks, system failures, or physical incidents.

Even with strong security controls in place, incidents can and will still occur at some point. BCM prepares the organization to operate and recover during these times.

=== Key Objectives

- Maintain critical operations during incidents. \ e.g., backups, redundant services, manual processing, etc.
- Minimize downtime and financial impact. \ e.g., fast system restore, emergency support contracts, incident response team, etc.
- Protect people, assets and reputation \ e.g., evacuation plans, fire suppression systems, customer notification processes, etc.
- Enable fast and structured recovery \ e.g., disaster recovery playbooks, tested backup restoration, post-incident review processes, etc.

== Security and Awareness Training

A coordinated program designed to ensure that all members of an organization understand their security responsibilities and have the knowledge and skills to protect information assets.

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  [], [Awareness (Level 1)], [Training (Level 2)], [Education (Level 3)],
  [Objective],
  [
    Seeks to teach members of an organization *what* security is and what to do in certain situations
  ],
  [
    Seeks to train members of an organization *how* they should react and respond to certain situations
  ],
  [
    Seeks to educate members of an organization as to *why* the organization reacts the way it does
  ],

  [Complexity\ Level],
  [
    Offers *basic information* about threats and responses
  ],
  [
    Offers more *detailed knowledge* about detecting threats and teaches skills needed for effective reaction
  ],
  [
    Offers the background and *depth of knowledge* to gain insight into how processes are developed and enables ongoing improvement
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

== Gap Analysis

The process of comparing an organization’s current security posture with a required or desired target to identify missing or insufficient controls.

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

== Security Framework

A structured set of principles, processes, and controls that organizations use to manage risks and protect their information systems, assets, and operations.

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

== ISO/IEC 2700

A set of standards for ISMS, helping organizations systematically protect information assets using a risk-based approach.

#deftbl(
  term: "Standart",
  [ISO/IEC 27000],
  [Introduction, terminology, and key concepts (e.g., risk, asset, control, etc.)],
  [ISO/IEC 27001],
  [Defines requirements to establish, implement, maintain, and improve an ISMS.],
  [ISO/IEC 27002],
  [Practical guidance for implementing controls.],
  [ISO/IEC 27005],
  [Focuses on risk management methodology.],
  [ISO/IEC 27017],
  [Additional guidance for cloud services.],
  [ISO/IEC 27018],
  [Focuses on privacy and personal data protection in cloud environments.],
)

== NIST Cybersecurity Framework

A risk-based guideline that helps organizations to structure, manage, and improve their cybersecurity activities across the full lifecycle of prevention, detection, and response.

- It’s organized into five core functions; Identify, Protect, Detect, Respond, Recover.
- Provides categories and subcategories of cybersecurity outcomes and controls.
- Includes implementation tiers to assess cybersecurity maturity.
- Is very flexible and adaptable to any organization or business sector.
- Not certifiable, primarily used as guidance and best practice.

== Risk, Vulnerabilities and Threats

=== Vulnerabilities

A potential weakness in an asset or its defensive control system. Can be *known* or *unknown*.

Examples:
- Software vulnerabilities (Bugs, design flaws, ...).
- Human vulnerabilities (sharing passwords, ...).

=== Threat

A potential malicious action, or event that aims to damage, or steal unauthorized access to assets. A threat exploits system vulnerabilities.

- Threat: What?
- Threat Actor: Who?
- Threat Vector: How?

=== Threat actors

#table(
  columns: (1fr, 1fr),
  [Motivations], [Actor Types],
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

=== Threat Vector

The path, method, or delivery mechanism that a threat uses to reach an asset and exploit a vulnerability.

Types:
- Software Vectors (Bugs, Virus, ...)
- Network Vectors (Bluetooth, Open Ports, Remote Network, ...)
- Lure-Based Vectors (Drop Attacks with USB Sticks, Trojans, ...)
- Message-Based Vectors (SMS, Email, IM, Web and Social Media, ...)
- Supply Chain Vectors (Updates, Libraries, ...)

=== Attack surface

The sum of vulnerabilities, pathways, or methods (Threat vectors) that hackers can use to gain unauthorized access to the network or sensitive data, or to carry out a cyberattack.

=== Risk

The probability of an unwanted occurrence, such as an undesirable event or loss.

- The definition of risk implies threats and vulnerabilities: A risk is only here if we have an existing vulnerability, threat, and threat vector!
- Risk = Vulnerability (Value & Exposure) + Threat (Threat Actor & Threat vector)

At what cost are we willing to accept what risk? The answer to that question gives us risk management.

== Risk Management

The process of identifying, assessing, prioritizing and mitigating threats to an asset from an organisation.

_Risk management framework_: Structure of the strategic planning and design of the entirety of the risk management efforts (planning).

_Risk management process_: implementation, analysis, evaluation of the risk management framework (doing).

#todo("slides 17")

=== RM Framework

+ _Executive Governance & Support_: Support from management and users.
+ _Framework Design_: Defining the methods and risk appetite strategy.
+ _Framework Implementation_: Rollout of the plan (through →RM process).
+ _Monitoring & Review_: How effective is the entire system?
+ _Continuous Improvement_: Continuous adaption to new , or existing threats.

==== Executive Governance and Support

#todo("slides 19")

==== Framework Design

Defining the methods and risk appetite strategy

#deftbl(
  [Risk appetite (strategic)],
  [The quantity of risk that organizations are willing to accept, to achieve their goals.],
  [Risk tolerance (specific)],
  [The acceptable risk organizations are willing to accept for a specific asset.],
  [Residual risk],
  [The risk that still remains after all controls have been applied. ],
)

==== Framework Implementation

Framework Implementation starts after:

- The RM framework and process is finished designing.
- The structure of the RM process & framework is defined.

The methodologies are dependent on the risk appetite:

- Direct rollout
- Pilot-test
- Phased approach

==== Monitoring & Review

- How successful was the framework in the last cycle?
  - Designing
  - Implementing
- What issues require adjustments to the plan?

=== Risk Management Process

#td([*Risk assessment*]): The identification, analysis, and evaluation of risk as initial parts of risk management.

#tg([*Risk treatment & Risk Owner*]): The application of safeguards or controls to reduce the risks to an organization’s information assets to an acceptable level.

+ #td([*Risk identification*]): Where and what is the risk?
+ #td([*Risk analysis*]): How severe is the current level of risk?
+ #td([*Risk evaluation*]): Is the current level of risk acceptable?
+ #tg([*Risk treatment*]): What do I need to do to bring the risk to an acceptable level?

=== Risk Identification

The recognition, enumeration, and documentation of risks to an organization’s information assets.

Where and what is the risk?

- What are the assets of the organisation? (Internal Asset Register, Weighted Asset Table)
  - Data, Software, Hardware, Networks, Employees, procedures, ...
- What are the threats of the organisation? (#link("https://attack.mitre.org/", "ATT&CK") is a globally-accessible knowledge base).
  - Human error, Attacks from hackers, forces of nature, day zero attacks ...
- What are the vulnerabilities? (#link("https://www.cve.org/", "CVE") and #link("https://www.first.org/cvss/calculator/3.1", "CVSS") helps with that question).
  - Lack of training, known bugs in the system, day zero exploit
- Precision is key: If THIS then THAT, because OF ...

=== CVE & CVSS

- A Common Vulnerabilities and Exposures (CVE) is an industry-wide standard identification number for vulnerabilities.
- The Common Vulnerability Scoring System (CVSS) uses the CIA triad principles within the metrics used to calculate the CVVS base score and assigns severity scores to a vulnerability

=== Risk Analysis

A determination of the extent to which an organization’s information assets are exposed to risk.

Identify the severity of every identified threat and vulnerability.

- What is the probability of an attack?
- What would be the impact of an attack?
  - Quantitative risk analysis assigns real dollar figures to the loss of an asset.
  - Qualitative risk analysis assigns subjective and intangible values to the loss of an asset.
- Existing Security Controls shall be considered

=== Quantitative Risk Analysis

+ Assign Asset Value (AV)
+ Calculate Exposure Factor (EF)
+ Calculate single loss expectancy (SLE)
+ Assess the annualized rate of occurrence (ARO)
+ Derive the annualized loss expectancy (ALE)
+ Perform cost/benfit analysis of countermeasures

==== AV

+ Identify the organization’s information assets.
+ Classify them.
+ Categorize them into useful groups.
+ Prioritize them by overall importance.

#exbox(title: "Weighted Asset Table", table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  align: center,
  [],
  [],
  [Impact on\ Revenue],
  [Impact on\ Profitability],
  [Impact on\ Reputation],
  [],
  [],
  [*\#*], [], [*0.3*], [*0.4*], [*0.3*], [*TOTAL\ (1.0)*], [*Importance*],
  [1], [Customer order via SSL], [5], [5], [5], [5], [Critically\ Important],
  [2], [Customer service request via e-mail], [3], [3], [5], [3.6], [Important],
  ..range(7).map(_ => $dots.v$),
))

==== EF, SLE

- _Exposure factor (EF)_: Represents the percentage of loss that an organization would experience if a specific asset is violated by a realized risk.
  - In most cases, a realized risk does not result in the total loss of an asset. The EF simply indicates the expect.
- _Single loss expectancy (SLE)_: The cost associated with a single realized risk against a specific asset. It indicates the exact amount of loss an organization would experience if an asset were harmed by a specific threat occurring.
  - SLE = asset value (AV) × exposure factor (EF)
  - Example: if an asset is valued at \$200,000 and it has an EF of 45 % for a specific threat, then the SLE of the threat for that asset is \$90,000.

==== ARO, ALE

- _Annualized rate of occurrence (ARO)_: The expected frequency with which a specific threat or risk will occur within a single year.
  - Example: The ARO of an earthquake in Paris may be .00001, whereas the ARO of an earthquake in San Francisco may be .03 (for a 6.7+ magnitude).
- _Annualized loss expectancy (ALE)_: The possible yearly cost of all instances of a specific realized threat against a specific asset.
  - ALE = single loss expectancy (SLE) ⋅annualized rate of occurrence (ARO)
  - If the SLE of an asset is \$90,000 and the ARO for a specific threat (such as total power loss) is .5, then the ALE is \$45,000.\ On the other hand, if the ARO for a specific threat (such as compromised user account) is 15, then the ALE would be \$1,350,00

==== ALE with Safeguards

- You must calculate the ALE for the asset if the safeguard is implemented.
  - This requires a new EF and ARO specific to the safeguard.
  - The whole point of a safeguard is to reduce the ARO and/or reduce the SLE. The best of all possible safeguards would reduce the ARO to zero.
  - In most cases, the EF to an asset remains the same even with an applied safeguard because if the safeguard fails, the loss on the asset is usually the same as when there is no safeguard.
- Safeguard Costs
  - You must first compile a list of safeguards for each threat. Then you assign each safeguard a deployment value = ACS (Annual cost of the safeguard).

==== Value of a Safeguard

Net Value or Cost/Benefit of a safeguard:

- Negative value: not a responsible choice.
- Positive value: Then the value represents the yearly savings in cost that you CAN have (because the rate of occurrence is just an expected value).

Safety needs to be cost effective. Do not use more resources or money for the protection of an asset as the value of the asset itself!

=== Risk Evaluation

The process of comparing an information asset's risk rating to the numerical representation of the organization’s risk appetite or risk threshold to determine if risk treatment is required.

Risk Evaluation: Compare the risk with the risk appetite of the organization.

- Can the company live with the analysed level of risk (From the CVSS, the quantitative risk analysis, qualitative risk analysis)?
- Levels: Expansionary, Conservative or Neutral

The Risk appetite from the RM Framework must be translated into a value so it can be compared to each analysed risk.

- For the quantitative risk analysis, the risk appetite can be translated into a numerical value!

Goal: The risk must be smaller or equal as the risk appetite.

- Important Indicators for Business Impact:
  - Maximum Tolerable Downtime (MTD)
  - Recovery Point Objective (RPO)
  - Recovery Time Objective (RTO) & Work Recovery Time (WRT)

=== Risk Treatment

Mitigation risk treatment strategy: The risk treatment strategy that attempts to eliminate or reduce any remaining uncontrolled risk through the application of additional controls and safeguards in an effort to change the likelihood of a successful attack on an information asset; also known as the defense strategy.

The company now has a list of information assets with unacceptable levels of risk.

- The appropriate strategy must be selected and applied.

Four basic strategies to treat risk:
+ Mitigation: Apply safeguards that eliminate or reduce the remaining uncontrolled risk.
  - Example: Firewall, Training, ...
+ Transfer: Shift risks to other areas or outside entities.
  - Example: Outsourcing
+ Acceptance: Understand the consequences of choosing to leave an information assets vulnerability facing the current risk level (after formal evaluation).
+ Termination: Remove or discontinue the asset from the organization's operating environment.

==== Mitigation

- Fix vulnerabilities
- Applying controls (tools, processes, rules to mitigate risk)
  - Endpoint Hardening (preventive Control): Secure a "endpoint" (device: laptop, server, ...) by reducing its vulnerabilities and shut down potential threat vectors!
- Reduce final impact (If zero-day attacks, unknown vulnerabilities, or a taken risk happen)
  - EDR (Endpoint Detection and Response): Software that watches for suspicious behaviour and responds with certain measures.
  - XDR (Extended Detection and Response): Watching everywhere (not just on endpoints) and respond with certain measures (shut down infected laptop, ...)

=== Other RM Frameworks

- OCTAVE (Operationally Critical Threat, Asset and Vulnerability Evaluation) by the Carnegie Mellon University.
- FAIR (Factor Analysis of Information Risk) by Jack A. Jones.
- ISO Standards: ISO 27005 and ISO 31000: (explanation: https://en.wikipedia.org/wiki/ISO/IEC_27005).
- NIST Risk Management Framework (RMF): https://csrc.nist.gov/publications/sp

= Identity & Access Management (IAM)

IAM deals with provisioning and protecting digital identities and user access permissions. Or in other words: The right people can access the right resources for the right reasons at the right time. To ensure this we need Access Controls.

== Access Control

Any hardware, software, or administrative policy or procedure that controls access to resources. The selective method by which systems specify who may use a particular resource and how they may use it.

The goal is to:

- PROVIDE access to authorized subjects
- PREVENT access to unauthorized access attempts and unauthorized subjects

#deftbl(
  [Subject],
  [
    Active entity that accesses a passive object.

    - Anything that can access a resource can be a subject: users, programs, processes, services, computers,...
  ],
  [Object],
  [
    Passive entity that provides information to subjects
    - Anything that can provide resources: files, databases, computers, programs, processes, services, printers, ...
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
    Items that you can physically touch. Included are physical mechanisms deployed to prevent, monitor, or detect direct contact with systems or areas within a facility
    - Examples: guards, fences, motion detectors, locked doors, sealed windows, lights, cable protection, laptop locks, badges, swipe cards, guard dogs, video cameras, mantraps, and alarms
  ],
  [Technical or\ logical controls],
  [Hardware or software mechanisms used to manage access and to provide protection for resources and systems
    - Examples: authentication methods (username, passwords, biometrics,...), encryption, access control lists, protocols,...
  ],
  [Administrative\ controls],
  [Policies and procedures defined by an organization’s security policy or other regulations or requirements
    - Examples: policies, procedures, hiring practices, background checks, data classifications and labeling, security training,...
  ],
)

#align(center, diagram(
  node-shape: fletcher.shapes.ellipse,
  node((0, 0), [Physical controls], name: <p>, stroke: none),
  node((0, 2), [Technical or logical controls], name: <t>, stroke: none),
  node((0, 4), [Administrative controls], name: <a>, stroke: none),
  node((0, 5), [Assets], name: <ass>, fill: colors-l.purple, inset: 1em),
  node(enclose: (<ass>, <a>), inset: 2em),
  node(enclose: (<ass>, <a>, <t>, (0, 7)), inset: 2em),
  node(enclose: (<ass>, <a>, <t>, <p>, (0, 8), (-8, 0), (8, 0)), inset: 2em),
))

#todo("slides 9-10")

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

=== Identification

The subject is claiming an identity.

- Example: Typing a username, swiping a smartcard, waving a token device, speaking a phrase, or positioning your face, hand, or finger in front of a camera or in proximity to a scanning device

*Important*: All subjects must have unique identities

- IT systems track activity by identities, not by the subjects themselves
- A subject’s identity is typically labeled as, or considered to be, public information

A subject must provide an identity to a system to start the other processes (authentication, authorization, and accountability)

=== Authentication

The process of verifying that the claimed identity (from identification) is valid

- Example: password
- Identification and authentication are often used together as a single two-step process

Authentication information used to verify identity is private information and needs to be protected

To authenticate the claimed identity it is common to use multiple factors These factors are often categorized in three different categories:

+ Something you know
  - A Type 1 authentication factor is something you know. Passwords, PINs, ...
+ Something you have
  - A Type 2 authentication factor is something you have. Physical devices that a user possesses can help them provide authentication
+ Something you are / you do
  - A Type 3 authentication factor is something you are or something you do. It is a physical characteristic of a person identified with different types of biometrics

#todo("examples?, (slides 16)")

==== Type 1 Factor: Passwords

Passwords are typically static. They are the weakest form of authentication

- Users often choose passwords that are easy to remember and therefore easy to guess or crack
- Randomly generated passwords are hard to remember, and many users write them down
- Users often share their passwords, or forget them
- Passwords are rarely stored in plaintext.
  - A system will create a hash of a password using a hashing algorithm
- Best practices and policies
  - Enforce a minimum length
  - Complexity rules (uppercase/lowercase, non-alphanumeric, etc...)
  - Ageing and expiration
  - Reuse and history
- Password managers mitigate the risk of poor credential management

==== Type 2 Factor: Tokens

A token device, or hardware token, is a device that users can carry with them

- An authentication server stores the details of the token, so at any moment, the server knows what number is displayed on the user's token

Hard Authentication Tokens

- No transmission of the token itself e.g. Smartcards, Hardware OTP Token

Soft Authentication Tokens

- Software token transmitted to the user e.g. via Authenticator App, SMS, Email or phone

Dynamic Password Tokens

- Synchronous create synchronous dynamic passwords are synchronized with an authentication server
- Asynchronous asynchronous dynamic password is based on a Challenge-Response principle

==== Type 2 Factor: Smartcard

A smartcard is a credit card–sized ID or badge and has an integrated circuit chip embedded in it

- Smartcards store information about the authorized user that is used for identification and/or authentication purposes
- Implements certificate-based authentication (private key and sometimes a PIN to activate the card)
- Most current smartcards include a microprocessor and one or more certificates. The certificates are used for asymmetric cryptography such as encrypting data or digitally signing email
- Smartcards are tamper-resistant and provide users with an easy way to carry and use complex encryption keys

==== Type 2 Factor: One-Time Passwords

Onetime passwords are dynamic passwords that change every time they are used

- Onetime password generators are token devices that create passwords
- The PIN can be provided via a software application running on the user’s device (e.g., smartphone)

TOTP (Time-based One-Time Password)

- Uses a timestamp and remains valid for a certain timeframe, such as 30 seconds
- This is similar to the synchronous dynamic passwords used by tokens

HOTP (HMAC-based One-Time Password)

- Includes a hash function to create onetime passwords. It creates HOTP values of six to eight numbers
- This is similar to the asynchronous dynamic passwords created by tokens. The HOTP value remains valid until used

==== Type 3 Factor: Biometrics

Biometric authentication uses physiological characteristics to provide authentication for a provided identification.

Errors: Biometrics make measurements and compare them with unique points of reference. This leads to errors (measurements always have errors):

- False reject rate (Type 1 Error): percentage of authorized users who are denied access
- False accept rate (Type 2 Error): percentage of unauthorized users who are granted access
- Crossover error rate (CER): The point at which the rate of false rejections equals the rate of false acceptances

==== Multifactor Authentication

Multifactor authentication is any authentication using two or more factors

- For a positive authentication, elements from at least two, and preferably three factors should be verified
  - When two authentication methods of the same factor are used together, the strength of the authentication is no greater than it would be if just one method were used
  - Using more types or factors results in more secure authentication

#todo("comparison (slides 24)")

==== Secondary Authentication Factors

In addition to the three primary authentication factors, there are some others

- Somewhere You Are
  - The somewhere-you-are factor identifies a subject's location based on a specific computer, a geographic location identified by an Internet Protocol (IP) address, or a phone number identified by caller ID
- Somewhere You Aren't
  - Many IAM systems use geolocation technologies to identify suspicious activity
  - For example, imagine that a user typically logs on with an IP address in Switzerland. If a user is trying to log on from a location in India, it can block the access even if the user has the correct username and password

=== Authorization

The process of authorization ensures that the requested activity or access to an object is possible given the rights and privileges assigned to the authenticated identity

Or in other words: Once a subject is authenticated, access must be authorized

- Just because a subject has been identified and authenticated does not mean they have been authorized to perform any function or access all resources within the controlled environment

Identification and authentication are all-or-nothing aspects of access control. This is NOT the case with authorization:

- Authorization has a wide range of variations between all or nothing for each object within the environment

==== DAC and NDAC

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

===== Discretionary access control (DAC)

Access controls that are implemented at the judgment or option of the data owner. Every object has an owner, and the owner can grant or deny access to any other subjects $->$ The owner (or user) chooses who has access!

- Most flexible and widely used e.g. file system security
- Data owner can modify access control list (ACL)
- Example: User has a hard drive and wants to share it with coworkers. He decides who he shares it with.

===== Nondiscretionary access control (NDAC)

Access controls that are implemented by a central authority.

- Example: US-Hospital where access is based on rules and regulations like HIPAA (DSG covers that in Switzerland)

====== Lattice-based access control (LBAC)

A variation on mandatory access controls that assigns users a matrix of authorizations for particular areas of access, incorporating the information assets of subjects such as users and objects.

- Mandatory access control (MAC): Use of labels applied to both subjects and objects. This means each collection of information is rated, and all users are rated to specify the level of access.
  - Example: Information are labelled as top secret $->$ only users that are labelled top secret are granted access to this information!
- Role-based (RBAC) / Task-based (TBAC) access control: privileges are tied to a role or a job (role-based) or to a task or assignment (task-based).
  - Example: Project manager has access to corresponding information about his project. (role-based)
  - Example: A technician is only allowed into a server room in his planned maintenance timeslot (task-based)

==== Least privilege design principle

Access rights should be limited in scope, time, and function

- "Just enough access" is usually better than broad permanent access

Users and systems should only get the permissions they actually need

- Reduces attack surface and limits damage after account compromise
- Helps prevent misuse of admin accounts and service accounts
- Supports separation of duties and stronger compliance

Requires regular access reviews and removal of unused permissions

=== Auditing

A subject's actions are tracked and recorded

Purpose: Hold the subjects accountable for their actions while authenticated on a system

=== Accounting

The consumption of resources by a subject is measured, metered, and collected.

Purpose: Provide a record of resource usage for billing, capacity planning, and trend analysis.

== Establishing accountability and non-repudiation

Accountability means actions can be traced to a specific identity

- Proving to regulators that your data is secure
- Link a human to the activities of an identity
- Requires unique user identities, no shared accounts and trong authentication
- Support your security decisions and their implementation
- Supports incident investigation, compliance, and trust in transactions

Non-repudiation means a user cannot credibly deny a performed action

- Logging and audit trails must be complete, accurate, and protected
- Digital signatures are a key mechanism for non-repudiation

== Common Access Control Attacks

=== Access Aggregation Attacks (passive attack)

- Access aggregation refers to collecting multiple pieces of nonsensitive information and aggregating them to learn sensitive information.
- Reconnaissance attacks are access aggregation attacks that combine multiple tools to identify multiple elements of a system, such as Internet Protocol (IP) addresses, open ports, running services, operating systems.

=== Password Attacks (brute-force attack)

- Online: Attacks against online accounts
- Offline: to steal an account database and then crack the passwords.

=== Dictionary Attack (brute-force attack)

An attempt to discover passwords by using every possible password in a predefined database or list of common or expected passwords also called a password-cracking dictionaries

- Dictionary attack databases also include character combinations commonly used as passwords, but not found in dictionaries
- Dictionary attacks often scan for one-upped-constructed passwords. A one-upped-constructed password is a previously used password, but with one character different.
- For example, password1 is one-upped from password, as are Password, 1password, and passXword

=== Birthday Attack (brute-force attack)

A birthday attack focuses on finding collisions. Its name comes from a statistical phenomenon known as the birthday paradox

- The birthday paradox states that if there are 23 people in a room, there is a 50 percent chance that any two of them will have the same birthday. (This is not the same year, but instead the same month and day, such as March 30)
- With February 29 in a leap year, there are only 366 possible days in a year. With 367 people in a room, you have a 99.99 percent chance of getting at least two people with the same birthdays. Reduce this to only 23 people in the room, and you still have a 50 percent chance that any two have the same birthday

You can reduce the success of birthday attacks by using hashing algorithms with enough bits to make collisions computationally infeasible, and by using salts.
- MD5 is not collision free
- SHA-3 (short for Secure Hash Algorithm version 3) can use as many as 512 bits and is considered safe against birthday attacks and collisions – at least for now

=== Rainbow Table Attacks

A rainbow table reduces the time by using large databases of precomputed hashes

- It takes a long time to find a password by guessing it, hashing it, and then comparing it with a valid password hash

A password cracker can then compare every hash in the rainbow table against the hash in a stolen password database file

- When using the rainbow table, the password cracker doesn’t spend any time guessing and calculating hashes. It simply compares the hashes until it finds a match
- This can significantly reduce the time it takes to crack a password

Salting

- adds a unique random value to each password before hashing
- prevents identical passwords from producing identical hash values

=== Sniffer Attacks

A sniffer (also called a packet analyzer or protocol analyzer) is a software application that captures traffic traveling over the network

- A sniffer attack (also called eavesdropping attack) occurs when an attacker uses a sniffer to capture information transmitted over a network

The following techniques can prevent successful sniffing attacks:
- Encrypt all sensitive data (including passwords) sent over a network. Attackers cannot easily read encrypted data with a sniffer
- Use onetime passwords (OTP) when encryption is not possible or feasible. OTPs prevent the success of sniffing attacks, because they are used only once, also see next chapter Kerberos
- Protect network devices with physical security. Controlling physical access to routers and switches prevents attackers from installing sniffers on these devices


