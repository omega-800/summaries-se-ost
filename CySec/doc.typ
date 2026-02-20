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

#todo("CySec / IT-Sec / Info-Sec visualization")

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

#todo("Vulnerabilities diagram")

- In storage
- In transit
- In use

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

#todo("pyramid diagram")
#diagram(
  // node((1,1), shape: triangle),
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
)
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

#todo("Cube visualization")

Y-Axis: Security Goals (C.I.A. Triad)
- Defines what needs to be protected.
X-Axis: Information States
- Describes where the information exists.
Z-Axis: Safeguards / Controls
- Defines how protection is implemented.

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
