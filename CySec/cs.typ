#import "../lib.typ": *
#import "./info.typ": info

#show: cheatsheet.with(..info)
#set enum(numbering: "1)1)")

= Information security (IS)

/ Information: Data that has been processed in a way that gives it meaning and
  value
/ Information security: Protection of the integrity, confidentiality and
  availability of information
/ Non-repudiation: Prevents parties from denying their actions
/ Accountability: Ability to trace actions back to a person
/ Authentication: Verifies the identity of a user or system
/ Authorization: Determines actions an entity is allowed to do
/ Access control: Restrict access to resources based on rules
/ Security policy: A rule/expectation for protecting information
/ Compliance: Adherence to laws, regulations, and standards
/ Types of information: Personal, business, financial, intellectual, system
/ Components of an Information System (IS): Software, Hardware, Data, People,
  Procedures, Networks
/ Bottom-Up: Implementations happen before policies
/ Top-Down: Initiated by management, more effective
/ McCumber cube: #tr[x: CIA (what)], #td[y: Information states (where)], #tg[z:
    Control (how)]
#tr[
  / (C)onfidentiality: Prevent unauthorized access to info
  / (I)ntegrity: Protect reliability and correctness of information
  / (A)vailability: Ensure uninterrupted access to information
]
#td[/ Information states: In *storage*, in *transit*, in *use*]
#tg[
  / Control: A measure designed to reduce the potential risk of an attack by eg.
    *Policy, Education, Technology*
]
/ (S)poofing: Pretending to be someone else
/ (T)ampering: Unauthorized data modification or altering
/ (R)epudiation: Denying actions without proof
/ (I)nformation disclosure: Exposing sensitive information
/ (D)enial of service: Making systems or services unavailable
/ (E)levation of privilege: Gaining unauthorized rights

= Threat categorization

== Social engineering

Manipulating people to reveal confidential information

/ Phishing: Forged emails impersonating legitimate entities
/ Spear Phishing: Targeted phishing to specific individuals
/ Vishing: Voice-based phishing over phone or video calls
/ Smishing: SMS / Text-based phishing

== Software Attacks

Exploiting vulnerabilities in software to gain access to a system or steal data

/ Virus: Malware that attaches to programs and spreads
/ Worms: Self-replicating malware that spreads over a network
/ Trojan Horse: Malicious sw disguised as legitimate apps
/ Ransomware: Encrypts victim data, asks payment to restore
/ Rootkits: Stealthy tools that hide malicious activity and maintain privileged
  access

== Denial of Service

Overloading one or multiple systems to make it unavailable

/ DoS: Single source denial of service attacks
/ DDoS: Dos performed by multiple attackers/devices
/ Botnet: Network of compromised devices controlled by an attacker and used to
  together to flood a target with traffic
/ SYN-Flood Attack: Sending many TCP connection requests without completing them
/ Reflection Attack: Attacker spoofs victim's IP, sends requests to a service so
  that it sends (many) replies to victim

== Web Application Attacks

Exploiting vulnerabilities in websites/servers hosting websites

/ SQL Injection: Insert malicious SQL commands into an input
/ Cross-Site Scripting (XSS): Inject malicious scripts into website that execute
  in users' browsers to steal data
/ Cross-Site Request Forgery (CSRF): Trick logged-in user's browser into sending
  reqs to a webapp on attacker's behalf
/ Broken Authentication: Weak auth mechanisms allow attackers to gain
  unauthorized access (password/session)

== Password / Authentication Attacks

Attempting to bypass or compromise login systems to gain unauthorized access

/ Rainbow Table Attacks: Precomputed hash lookup tables to reverse weakly hashed
  passwords back into plaintext
/ Password Spraying: Trying a few common passwords like “password” across many
  accounts to avoid lock-/timeouts
/ Credential Stuffing: Using leaked credentials from previous breaches to
  attempt logins on other services
/ Brute Force Attack: Repeatedly try many username & password combinations until
  they gain access to an account

== Physical Attacks

Bypassing technical controls by accessing physical infrastructure directly

/ Theft of devices: Physically steal hardware to gain direct access to stored
  data, credential, internal systems, ...
/ Hardware tampering: Modify/implant malicious components in to intercept data,
  bypass security, or disrupt operations
/ Power disruption: Interrupt or manipulate power supply impacting availability
  and business continuity
/ Environmental damage: Environmental events that damage infrastructure, causing
  data loss, downtime, ...

= Information security management (IMS)

#todo[notes 12]
/ Information security governance: System by which IS strategy is controlled to
  ensure that it supports business objectives, manages risk appropriately, and
  complies with legal and other regulatory requirements. (*what*)
/ Information Security Management System (ISMS): Framework used to manage and
  protect assets through policies, processes and controls (*how*)
/ Enterprise Information Security Policy (EISP): Information security policy
  that sets the strategic direction and scope for all an organization's security
  efforts
/ Risk Management Process: Definition of processes to identify assets, analyze
  threats and evaluate risk
/ Security Awareness and Training: Educational programs to ensure employees
  understand their security responsibilities
/ Monitoring, Measurement and Audits: Ongoing evaluation of control
  effectiveness and ISMS performance

= Policy

/ Practices: Ex. actions that illustrate compliance with policies
/ Policy: Instructions that dictate certain behavior within an org
/ Standard: Details of what must be done to comply with policy
/ Guidelines: Non-mandatory recommendations (reference)
/ Procedures: Step-by-step instructions designed to assist employees in
  following policies
/ De jure standard: Formally evaluated and approved by a formal standards
  organization
/ De facto standard: Widely adopted/accepted by public group

#todo[notes 14,15]

= Risk Analysis

#tp[Identify Assets] $->$ #tg[Identify Threats] $->$ Identify Vulnerabilities
$->$ Assess Likelihood $->$ Assess Impact $->$ Determine Risk Level

#tp[
  / Asset: *Item of value belonging to an organization. eg:*
  / Information: Customer data, intellectual property, code
  / Technical: Services, applications, databases, networks
  / Physical: Servers, devices, facilities, infrastructure
  / Human: Employees, administrators, contractors
  / Business Process: Critical operational workflows
]
#tg[
  / Threat: An event or action with the potential to cause harm by exploiting a
    vulnerability. eg: power outage, vishing
]

== Classifying assets

/ Public: Information that can be shared without risk
/ Internal: Information for organization internal use only
/ Confidential: Sensitive info, could cause harm if disclosed
/ Restricted: Highly sensitive,strictly limited,strongly protected

== Security controls

#tp[
  / Administrative/Management Controls: Policies, procedures, security training,
    security governance
  / Technical / Logical Controls: Firewalls, encryption, access control systems,
    system hardening
  / Physical Controls: Physical locks, surveillance cameras, secure access
    badges, turnstiles
]
#td[
  / Preventive Controls: Stop incidents before they occur. eg. Firewalls, access
    control, encryption
  / Detective Controls: Identify incidents when they occur. eg. Intrusion
    detection, log monitoring, SIEM, CCTV
  / Corrective Controls: Limit damage, restore systems after an incident. eg.
    Backups, system restore, incident response
  / Deterrent Controls: Discourage malicious behavior. eg. Warning banners,
    monitoring notices, disciplinary policies
  / Compensating Controls: Reduce risk when a primary control cannot be
    implemented. eg. Network isolation, layered security, alternative safeguards
]
/ Business continuity: Ensures critical operations continue during disruptions.
  Objectives: maintain operations, minimmize impact, protect assets, recover
  fast
=== Security and awareness training
+ *Awareness*: basic information, *what*
+ *Training*: detailed knowledge, *how*
+ *Education*: depth of knowledge, *why*

== Gap analysis

Define target framework $->$ Assess curr state $->$ Identify gaps, assess risk
$->$ Eval, prioritize gaps $->$ Create remediation plan

== Security framework

/ NIST Cybersecurity Framework: Framework for managing cyber risk: Identify,
  Protect, Detect, Respond, Recover
/ CIS Controls: Defines 18 practical technical security controls

== Threats

/ Attack: Act that intends to damage, steal or degrade assets
/ Vulnerability: A weakness in a system that can be abused
/ Exploit: A method used to take advantage of a vulnerability
/ Risk: The likelihood of a threat exploiting a vulnerability and the potential
  harm that could cause = Vulnerability + Threat
/ Threat vector: Path, method, or delivery mechanism that a threat uses to reach
  an asset and exploit a vulnerability
/ Attack surface: Sum of threat vectors that hackers can use to carry out a
  cyberattack.

== Risk Management (RM)

The process of identifying, assessing, prioritizing and mitigating threats to an
asset from an organisation.

#tg[
  / Risk management process: Implementation, analysis, evaluation of the risk
    management framework (doing). \
    #td[*Risk assessment*]: The identification, analysis, and evaluation of risk
    as initial parts of risk management. \
    #tg[*Risk treatment & Risk Owner*]: The application of safeguards or
    controls to reduce the risks to an organization’s information assets to an
    acceptable level. \
    + #td[*Risk identification*]: Where and what is the risk?
    + #td[*Risk analysis*]: How severe is the current level of risk?
    + #td[*Risk evaluation*]: Is the current level of risk acceptable?
    + #tg[*Risk treatment*]: What do I need to do to bring the risk to an
      acceptable level?
]
#tp[
  / Risk management framework: Structure of the strategic planning and design of
    risk management efforts (planning). \
  + _Executive Governance & Support_: Support from management and users.
  + _Framework Design_: Defining the methods and risk appetite strategy.
  + _Framework Implementation_: Rollout of the plan (through →RM process).
  + _Monitoring & Review_: How effective is the entire system?
  + _Continuous Improvement_: Continuous adaption to new , or existing threats.
]
/ Risk appetite (strategic): The quantity of risk that organizations are willing
  to accept, to achieve their goals
/ Risk tolerance (specific): The acceptable risk organizations are willing to
  accept for a specific asset
/ Residual risk: Remaining risk after controls were applied

#todo("slides 17,19 (notes 19,20), risk identification, risk analysis")

/ Common Vulnerabilities and Exposures (CVE): Standard identification number for
  vulnerabilities
/ Common Vulnerability Scoring System (CVSS): Severity scores for
  vulnerabilities based on CIA

=== Quantitative Risk Analysis

+ Assign Asset Value (AV)
  + Identify the organization’s information assets.
  + Classify them.
  + Categorize them into useful groups.
  + Prioritize them by overall importance.
+ Calculate Exposure Factor (EF)
  - percentage of loss that an organization would experience if a specific asset
    is violated by a realized risk
+ Calculate single loss expectancy (SLE)
  - Exact amount of loss if an asset were harmed by a threat
  - SLE = AV $times$ EF
+ Assess the annualized rate of occurrence (ARO)
  - Expected occurrence frequency of a threat within a year
+ Derive the annualized loss expectancy (ALE)
  - possible yearly cost of all instances of a realized threat against an asset
  - ALE = SLE $times$ ARO
+ Perform cost/benfit analysis of countermeasures
#todo[ALE with safeguards, risk evaluation, risk treatment, mitigation (notes
  22,23)]

= Identity & Access Management (IAM)

Provisioning and protecting digital ids & access permissions

/ Subject: Active entity that accesses a passive object. \ users, programs,
  processes, services, computers
/ Object: Passive entity that provides information to subjects. files,
  databases, computers, programs, services, printers
#td[
  / Physical controls: To prevent, monitor, or detect direct contact with
    systems: guards, fences, motion detectors
  / Technical or logical controls: To manage access and provide protection for
    resources. auth, encryption, ACL
  / Administrative controls: Policies and procedures. hiring practices,
    background checks, security training
]
#tp[
  / Identification: Claiming an identity, eg. typing a username
  / Authentication: Verifying validity of claimed id, eg. password
    + Something you know, eg. password
    + Something you have, eg. smartcard
    + Something you are/something you do, eg. biometrics
    + Somewhere you are / aren't (secondary factor)
]
/ Basic Authentication: Username/pw transmitted in the clear
/ One Time Passwords: Basic auth but used only once
/ Challenge / Response: Password and one-time challenge
/ Anonymous Key Exchange: Exchange credentials over unauthenticated secure
  channel, eg. diffie-hellmann
/ Zero-Knowledge Password Proofs: Does not permit offline-based password attacks
/ Server Certificates + User Authentication: Transmit user password over
  unilaterally authenticated secure channel
/ Mutual Public Key Authentication: Bilateral use of public key signatures
/ Multifactor Auth: Using two or more factors

== Kerberos
Uses symmetric key encryption (DES)
#{
  let node = node.with(height: 2em, width: 4em)
  align(center, diagram(
    spacing: (14em, 3em),
    node((0, 0), [KDC], name: <k>),
    node((1, 0), [TGS], name: <t>),
    node((0, 1), [Client], name: <c>),
    node((1, 1), [Server], name: <s>),
    edge(<k>, <c>, "-|>", shift: .05),
    edge(<t>, <c>, "-|>", shift: .1),

    edge(<c>, <t>, "-|>", shift: .1, label: box(
      width: 13em,
      height: 1em,
      fill: colors.bg,
      place(dx: 2em)[2. Access control for server],
    )),
    edge(<c>, <k>, "-|>", shift: .05, label: box(
      width: 10em,
      fill: colors.bg,
      [1. Authenticate user],
    )),
    edge(<c>, <s>, "-|>", label: [3. Communication]),
  ))
}

/ Principal: A Kerberos participant
/ Principal's Master Key: Long-term secret between the principal and KDC. Used
  to en-/decrypt authentication tickets.
/ Kerberos Ticket: Temporary credential for network services
/ Authentication Server (AS): Verifies client, gives TGT
/ Ticket Granting Server (TGS): Grants services, gives ST
/ Ticket Granting Ticket (TGT): Given by the AS
/ Service Ticket (ST): Given by the TGS
/ Key Distribution Center (KDC): Verifies & manages auth credentials,
  distributes session keys to users and services

== RADIUS

Remote Authentication Dial-In User Service provides centralized Authentication,
Authorization and Accounting (AAA)

+ User requests access from Network Access Server (NAS)
+ NAS prompts the RADIUS server for credentials
+ RADIUS server evaluates the request and returns one of:
  - Access-Accept: User authenticated, NAS grants access
  - Access-Reject: Invalid credentials, NAS denies access
  - Access-Challenge: Server requires more info (MFA)
+ Connected: NAS sends Accounting-Request (log session)

#align(center, table(
  columns: 3,
  table.header(align(left)[Attack], [Kerberos], [RADIUS]),
  align(left)[Passive Password Sniffing], [], [],
  align(left)[Offline Brute Force Password Attack], cr, cr,
  align(left)[Active Man-in-the-Middle Attack], [], cr,
  align(left)[Identity Theft on Server], [], [],
  align(left)[CA Compromise], [], cr,
))

== Authorization

#diagram(
  spacing: (0em, .5em),
  node-stroke: none,
  node((1, 0), [Access Control], name: <ac>),
  node((.5, 1), [Nondiscretionary], name: <nd>),
  node((1.5, 1), [Discretionary], name: <d>),
  node((.5, 2), [Lattice-based], name: <lb>),
  node((0, 3), [Mandatory], name: <m>),
  node((1, 3), [Role-based/Task-based], name: <rb>),
  edge(<ac>, <nd>),
  edge(<ac>, <d>),
  edge(<nd>, <lb>),
  edge(<lb>, <m>),
  edge(<lb>, <rb>),
)

/ Discretionary access control (DAC): Every object has an owner, the owner can
  grant or deny access (sharing drive)
/ Nondiscretionary access control (NDAC): Access controls that are implemented
  by a central authority (HIPAA/DSG)
/ Lattice-based access control (LBAC): Assigns users a matrix of authorizations
  for particular areas
/ Mandatory access control (MAC): Labels applied to both subjects and objects
  (classified documents $<->$ glowies)
/ Role-based access control (RBAC): Privileges are tied to a role or job
  (project info $<->$ project manager)
/ Task-based (TBAC) access control: Privileges are tied to a task (access to
  server room $<->$ technician's time slot)
#td[
  / Auditing: A subject’s actions are tracked and recorded
  / Accounting: Consumption of resources by a subject is measured, metered, and
    collected.
]
#todo[shorten all this below]
/ Salting: Adds unique random value to each password before hashing, prevents
  identical passwords from producing identical hash values
#tr[
  / Access Aggregation Attacks (passive attack): Collecting multiple pieces of
    nonsensitive information and aggregating them to learn sensitive information
    (Reconnaissance attack)
  / Password Attacks (brute-force attack):
    - Online: Attacks against online accounts
    - Offline: to steal an account database and then crack the passwords.
  / Dictionary Attack (brute-force attack): An attempt to discover passwords by
    using every possible password in a predefined database
  / Birthday Attack (brute-force attack): Finding collisions.
    - MD5 is not collision free
    - SHA-3 is considered safe against birthday attacks and collisions
  / Sniffer Attacks: Application that captures traffic traveling over the
    network
    - Encrypt all sensitive data
    - Use onetime passwords (OTP)
    - Protect network devices with physical security
]

= Cryptography

/ Ciphertext/Cryptogram: Encrypted message
/ Cipher: Encryption algorithm. Set of rules for en-/deciphering
/ Key/Cryptovariable: Usually a very large binary number
/ Key space: Range of numbers from $0$ to $2^n$, where $n$ is the bit size of
  the key. A $128$-bit key is $in {0,...,2^128}$
/ One-Way Functions: Easily produces output values but makes it impossible to
  retrieve the input values
/ Reversability: Being able to undo the operation of encryption
/ Nonce: Must be a unique number each time it is used. Used to make sure that a
  key is not re-used twice. The nonce is public, whereas the (shared) key is
  private
/ Initialization vector (IV): Random bit string, same length as the block size
  and is XORed with the message to create unique ciphertext every time same
  message is encrypted
/ Steganography: Embedding secret messages within content
/ Objectives: Confidentiality (Privacy), Integrity, Authentication,
  Non-repudiation
/ Kerkhoff's Principle: Security stems from the secrecy of the key and not the
  secrecy of the algorithm
/ Shannon's Principles:
  / Confusion: Relationship between the plaintext and the key is complicated.
    S-Box, substitution
  / Diffusion: Change in plaintext results in multiple changes spread throughout
    the ciphertext. P-Box, permutation
/ SP-Network: Repeated substitution and permutation
/ One-Time-Pad (OTP): XORing all bytes with same size OTP
/ Hashing: Maps data to fixed-size output. Should be: random, diffused, fast,
  deterministic, irreversible, collisionless
#todo[hashing algos (notes 36, 37)]

#pagebreak()
This summary was created thanks to the motivation provided by #link(
  "https://turnstilehc.bandcamp.com/track/stress",
  "turnstile",
), #link(
  "https://wisdominchains.bandcamp.com/track/chasing-the-dragon-2",
  "wisdom in chains",
) and #link("https://flatspotrecords.bandcamp.com/track/245a", "hands of god")
