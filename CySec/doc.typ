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

#todo("security governance responsibilities")

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

#todo("diagram (slides 9)")

_What does a policy do?_
Establishes authority, accountability, and responsibilities for protecting information assets. Provides the foundation for standards, procedures and guidelines.

_Who is responsible for policies?_
Policies are created and approved by senior management, ensuring organizational commitment. Management is responsible for enforcement while employees and users are responsible for compliance.

_How is a policy enforced?_
By clearly communicating it to all relevant parties, integrating it into standards and procedures, monitoring compliance through audits and oversight, and applying defined disciplinary measures when violations occur.

#todo("policies (slides 11)")

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

#todo("flowchart/steps")

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
  [Administrative / Management Controls],
  [Policies, procedures, security training, security governance, etc.],
  [Technical / Logical Controls],
  [Firewalls, encryption, access control systems, system hardening, etc.],
  [Physical Controls],
  [Physical locks, surveillance cameras, secure access badges, turnstiles, etc.],
)

== By Function

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

#todo("Flowchart/Steps")

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
