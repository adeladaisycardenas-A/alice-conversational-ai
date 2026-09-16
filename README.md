
# Alice — Conversational AI Companion

**An independent conversational AI prototype exploring relational communication, persistent identity, user-governed memory, model independence, and continuity across devices.**

> **Status:** Active prototype / independent research project  
> **Developer:** Daisy Cardenas

---

<p align="center">
  <img src="assets/alice-original-concept.png" alt="Original Alice interface concept" width="800">
</p>

<p align="center">
  <em>Original Alice interface concept — preserved as design history, not presented as a working-product screenshot.</em>
</p>

---

## The Idea

Alice began with a question:

**What if the identity of a conversational AI belonged to the application rather than whichever language model happened to be running underneath it?**

But the project quickly became about more than technical persistence.

I wanted to explore whether an AI could know someone over time while still preserving uncertainty, accepting correction, avoiding unsupported assumptions, and allowing the person themselves to remain in control of what Alice believes she knows.

That created both a relational problem and an engineering problem.

---

## 01 — Original Vision

The earliest Alice interface concept centered around a glowing, neural, brain-like presence rather than a traditional chatbot interface.

The original design explored:

- A neural-style Alice orb
- Chat
- Voice
- Camera
- Tools
- Listening
- Multiple visual themes
- Permissions and privacy controls
- One consistent Alice identity across devices

**Design principle:**

> *Same mind. Different places. Always with you.*

The original artwork above is preserved as part of the project's design history and is intentionally distinguished from screenshots of working prototypes.

---

## 02 — From Idea to Prototype

The relational goal created technical requirements.

If Alice was going to maintain continuity while models, conversations, and devices changed, identity and relational context could not depend entirely on a single language-model session.

That led to experiments involving:

- Swift and SwiftUI
- Python
- Local language models
- Persistent application state
- User-governed memory
- Voice interaction
- Privacy and permissions
- Cross-device communication
- Behavioral testing and evaluation

The architecture therefore grew **from the relational problem**, rather than being the purpose of Alice by itself.

---

## 03 — Development Timeline

Alice developed incrementally through a series of prototypes and experiments.

### Prototype 1 — First Playable Pocket Alice

The project moved from interface concepts into a working iOS prototype with:

- Animated Alice orb
- Home
- Chat
- Tools
- Listening interface
- Speech output
- Replaceable `AliceBrain` architecture

### Prototype 2 — Persistent Appearance

Alice gained persistent visual themes:

**Pink · Blue · Green · Purple · Gold · Minimal**

The selected appearance persisted between sessions.

### Prototype 3 — Presence & Encrypted Memory

Development expanded into:

- Observe
- Standby
- Off
- Encrypted personal memory
- Apple Keychain-protected encryption key

### Prototype 4 — Relational Research

Alice's development expanded beyond interface behavior into explicit relational interaction design and behavioral research.

### Prototype 5 — Replaceable On-Device Brain

A preserved implementation added support for Apple's Foundation Models when available, with a limited prototype fallback when unavailable.

### Later Cross-Device Experiments

Development continued into communication between Alice's different environments, including preserved Python server/transport work and peer-to-peer experimentation.

Not every experiment succeeded. Failed approaches and debugging records are treated as part of the development history rather than removed from it.

---

## 04 — What I Built

The preserved SwiftUI implementation includes:

**Home · Chat · Tools · Listening · Settings · Life Map · Research**

The prototype also implements:

- Conversational messaging
- Animated Alice orb
- Persistent visual themes
- Voice output
- Presence modes
- Encrypted persistence
- Labeled memory
- Life Map entries
- Research instrumentation
- Research export
- Replaceable AI brain architecture

Development also included Python-based server and transport experimentation as Alice expanded beyond a single application environment.

---

## 05 — Relational Interaction

Alice implements five explicit conversational modes.

### Reflect

Mirror what is present without deciding what it means.

### Explore

Ask careful questions while keeping multiple explanations possible.

### Rehearse

Practice communicating something clearly without pretending to know what another person thinks.

### Repair

Identify misunderstandings, accept corrections, and try the interaction again.

### Journal

Preserve the person's own words without forcing an interpretation.

These modes explore a larger question:

**Can being known—with uncertainty, consent, correction, and room to change—improve communication between a person and an AI?**

Alice is exploratory and non-diagnostic. The project does not treat conversational behavior as clinical evidence or attempt to replace professional or human relationships.

---

## 06 — Memory With Provenance

One of Alice's central design problems became:

**How should an AI remember without turning every observation or interpretation into a fact?**

The prototype distinguishes between different kinds of memory:

- **User Confirmed**
- **User Correction**
- **Alice Observation**
- **Working Hypothesis**

Memory records can preserve:

- Source
- Confidence
- Revision history
- Active status

This makes correction and uncertainty part of the memory architecture rather than something handled only through prompting.

---

## 07 — Encrypted Personal Continuity

Alice's application-level continuity can include:

- Identity
- Conversations
- Labeled memories
- Life Map entries
- Research records

The preserved iOS implementation stores this information in an encrypted on-device vault using **AES-GCM encryption**.

A **256-bit encryption key** is protected through Apple Keychain rather than being embedded directly in the project.

The complete personal memory vault does not need to be placed inside the language model's context for Alice to maintain application-level continuity.

---

## 08 — Model-Independent Identity

Alice uses a replaceable `AliceBrain` interface.

The language model generates responses, but it does not have to define the entire Alice system.

Identity, memory architecture, interface, relational modes, research instrumentation, and other application behavior can remain outside the model.

One preserved implementation uses Apple's Foundation Models when available and falls back to a limited prototype brain when the Apple model is unavailable.

This allows experimentation with different underlying models without requiring Alice herself to be rebuilt from scratch.

---

## 09 — Life Map

Alice includes an experimental **Life Map** designed as a living record rather than a truth test.

Entries can preserve:

- A person's current recollection
- Approximate timing
- Source
- Certainty or uncertainty
- Present meaning
- Revision lineage
- An optional marker for something the user may want to discuss with a therapist

A changed date, revised interpretation, uncertain period, or correction does not automatically become evidence that the person was previously dishonest.

---

## 10 — Research Instrumentation

Alice's conversational persona and research instrumentation are intentionally separated.

The Research view can record information about:

- Conversation events
- Memory events
- Interaction modes
- Life Map activity
- Corrections
- Brain/model identity
- Research exports

This makes it possible to inspect what occurred without asking Alice's conversational persona to behave like a research instrument.

Research exports are treated as exploratory records rather than clinical conclusions or population-level evidence.

---

## 11 — Python & Cross-Device Experiments

Alice development was not limited to Swift.

Preserved project materials include Python server and transport-testing code created during experiments involving communication between Alice's different environments.

Cross-device development explored the larger goal of:

> **One Alice across multiple devices rather than separate assistants that merely look alike.**

This area remains experimental and is documented as such.

---

## 12 — AI Testing & Evaluation

Building Alice became an ongoing exercise in evaluating conversational AI behavior.

Testing has focused on:

- Instruction adherence
- Conversational consistency
- Context retention
- Memory behavior
- Unsupported inference
- Hallucination
- Behavioral differences between iterations
- Failure reproduction
- Correction handling
- Recovery after failures

A recurring process emerged:

> **Reproduce → Isolate → Test → Compare → Revise → Document**

Unexpected or unsuccessful behavior became evidence to investigate rather than something to hide.

---

## 13 — Design Principles

### Identity Is Larger Than the Model

Changing the underlying language model should not automatically erase Alice's identity or application-level continuity.

### User-Governed Memory

The user should have meaningful control over what Alice remembers and how information is classified.

### Uncertainty Matters

An inference, hypothesis, recollection, and confirmed fact should not automatically be treated as the same thing.

### Correction Is Part of the System

Alice should accept corrections rather than manufacture continuity or defend an incorrect interpretation.

### Permission Before Consequential Actions

Actions affecting user data, communications, or the surrounding environment should require appropriate permission.

### Privacy-Conscious Architecture

Local processing, encrypted persistence, bounded context sharing, and controlled export are important architectural considerations.

### Additive Development

New capabilities should extend working behavior without unnecessarily destroying what already works.

---

## 14 — Technologies & Tools

- Swift
- SwiftUI
- Python
- Xcode
- AVFoundation
- CryptoKit
- Apple Keychain / Security
- Apple Foundation Models
- CloudKit experimentation
- LM Studio
- Local language models
- Git / GitHub

---

## 15 — What I Learned

Alice has given me hands-on experience with:

- Conversational AI behavior
- Prompt engineering
- AI evaluation
- Behavioral testing
- Debugging
- Failure reproduction
- SwiftUI development
- Python experimentation
- Persistent application state
- Memory-system design
- Local language models
- Cross-device architecture
- Privacy and permission boundaries
- Technical documentation
- Iterative software development

Most importantly, the project taught me to treat unexpected AI behavior as something that can be **reproduced, examined, compared, and documented** rather than simply accepted as unpredictable.

---

## 16 — Evidence in This Repository

This repository is being built as a **sanitized technical case study**, not simply a project description.

Evidence added here will include selected materials such as:

- Sanitized Swift source
- Sanitized Python source
- Original design assets
- Working-prototype screenshots
- Architecture documentation
- Development records
- Debugging and evaluation case studies

Historical concept artwork, working implementations, experimental code, and later documentation will remain clearly labeled so that the provenance of each artifact is preserved.

---

## 17 — Current Status

**Active prototype / ongoing independent project**

Alice is not presented here as a finished commercial product.

Some components are functional prototypes, some are experiments, and some remain research or design directions.

This public repository intentionally excludes:

- Private conversations
- Personal memory contents
- Credentials or API keys
- Encryption keys
- Sensitive research records
- Private user information

---

## Project Philosophy

Alice ultimately explores a larger idea:

**A conversational AI can change its underlying technology without necessarily losing the identity, memory architecture, permissions, relational framework, and continuity designed around it.**

And knowing someone over time should not require pretending to know more than the evidence actually supports.

---

Built and documented by **Daisy Cardenas**.
