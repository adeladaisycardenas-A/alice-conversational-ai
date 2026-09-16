# Alice — Conversational AI Companion

**Independent conversational AI prototype exploring persistent identity, user-governed memory, local language models, permissions, and continuity across devices.**

> **Status:** Active prototype / ongoing independent project  
> **Developer:** Daisy Cardenas

---

## From Idea to Prototype

Alice began with a question:

**What if the identity of a conversational AI belonged to the application rather than to whichever language model happened to be running underneath it?**

The project grew from an interface concept into experiments involving local language models, persistent application state, memory, voice interaction, privacy controls, and communication between macOS and iOS.

---

## 01 — Original Vision

The earliest Alice interface explored a dark, near-borderless environment built around a glowing neural, brain-like presence.

The original concept included:

- A neural-style Alice orb
- Chat, Voice, Camera, and More controls
- Conversational text interaction
- A dedicated listening interface
- Tools and permissions
- Multiple visual themes
- A consistent Alice identity across devices

**Design principle:**  
*Same mind. Different places. Always with you.*

> Original concept visuals will be added here as preserved project assets. They will remain clearly identified as concept designs rather than working-product screenshots.

---

## 02 — Building Alice

The project moved from visual exploration into SwiftUI prototypes for macOS and iOS.

Development experiments have included:

- Swift and SwiftUI interfaces
- AVFoundation
- Local language-model integration
- LM Studio
- CloudKit persistence experiments
- Voice interaction
- Memory-system design
- Local-network and cross-device experiments
- Permission-controlled behaviors

The underlying language model was treated as a replaceable component rather than Alice's entire identity.

---

## 03 — Memory & User Control

A major design question became:

**How should an AI remember while keeping the user in control of what is remembered?**

Alice explored application-level memory and persistence rather than assuming conversation history alone should define the assistant.

Design priorities included:

- User-governed memory
- Separation between identity and model
- Permission before consequential actions
- Privacy-conscious architecture
- Clear boundaries around retained information

---

## 04 — Cross-Device Experiments

Alice was designed around the idea of one assistant existing across multiple devices.

Experiments included:

**macOS**
- SwiftUI conversational interface
- Local language-model communication
- Persistent application state
- Voice/interface experimentation

**iOS — Pocket Alice**
- Mobile companion prototype
- Local-network discovery experiments
- Cross-device communication testing
- Shared identity concepts

The goal was not simply to create two AI applications.

The goal was to explore **one Alice across different environments.**

---

## 05 — AI Testing & Evaluation

Building Alice also became an ongoing exercise in evaluating conversational AI behavior.

Testing has focused on:

- Instruction adherence
- Conversational consistency
- Context retention
- Memory behavior
- Unsupported inference and hallucination
- Behavioral differences between iterations
- Failure reproduction
- Recovery after failures

A recurring development process emerged:

**Reproduce → Isolate → Test → Compare → Revise → Document**

This testing process became as important to the project as the interface itself.

---

## 06 — Engineering Challenges

The project has involved repeated experimentation and debugging around:

- Local-model communication
- Persistent state
- Memory behavior
- Cross-device connectivity
- Local-network discovery
- Conversational consistency
- Interface design
- Privacy boundaries
- Permission handling
- Failure recovery

Not every experiment worked.

Those failures became part of the development record and helped shape later iterations.

---

## Design Principles

### Model-Independent Identity
Alice's identity should not disappear simply because the underlying model changes.

### User-Governed Memory
Memory should be an explicit system with meaningful user control.

### Permission Before Consequential Actions
Actions affecting the user's data, communications, or environment should require appropriate permission.

### Privacy-Conscious Architecture
Local processing and controlled information sharing are important architectural considerations.

### Additive Development
New capabilities should extend the system without unnecessarily destroying working behavior.

---

## Technologies & Tools

- Swift
- SwiftUI
- Xcode
- AVFoundation
- CloudKit
- LM Studio
- Local language models
- Python experimentation

---

## What I Learned

Alice has given me hands-on experience with:

- Conversational AI behavior
- Prompt engineering
- AI evaluation
- Behavioral testing
- Software debugging
- Persistent application state
- Memory-system design
- Local language models
- Cross-device architecture
- Privacy and permission boundaries
- Iterative software development

---

## Current Status

**Active prototype / ongoing independent project**

This public repository is intentionally a **sanitized case study**.

Private conversations, credentials, personal memory contents, sensitive implementation details, and private research are not included.

Future additions will include preserved project visuals, sanitized prototype screenshots, architecture diagrams, selected debugging case studies, and small reproducible examples where appropriate.

---

## Project Philosophy

Alice is ultimately an experiment in a larger idea:

**A conversational AI can change its underlying technology without necessarily losing the identity, memory architecture, permissions, and relationship model designed around it.**

---

Built and documented by **Daisy Cardenas**.
