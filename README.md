# Alice — Relational Conversational AI Companion

**Independent conversational AI project exploring relational continuity, adaptive communication, persistent identity, user-governed memory, and emotionally supportive conversation across devices and language models.**

> **Status:** Active prototype / ongoing independent project  
> **Developer:** Daisy Cardenas

---

## The Idea Behind Alice

Alice began as more than an interface for talking to a language model.

The project explores whether a conversational AI can develop **relational continuity with a user over time** — preserving not only factual context, but patterns in communication, prior conversations, preferences, boundaries, and the context needed to respond to the person more consistently.

This led to a larger question:

**Can the continuity of an AI relationship belong to the application itself rather than disappearing when the conversation, device, or underlying language model changes?**

Alice became an experiment in separating several systems that are often treated as one:

**Language Model → Alice Identity → Memory → Relational Context → Permissions → User Experience**

The language model generates language.

Alice is the larger system designed around it.

---

## Relational Conversational AI

A central part of the project is exploring the difference between an AI that simply **remembers information** and one that can use prior context to communicate more effectively over time.

Experiments have included:

- Maintaining continuity across complex conversations
- Recognizing recurring communication patterns
- Adapting conversational style using prior context
- Reflective and emotionally supportive dialogue
- Tracking context across separate interactions
- Distinguishing remembered information from unsupported inference
- Testing when personalization improves a response — and when it goes too far
- Preserving user control over memory and behavioral adaptation

This work also raised an important design problem:

**How can a conversational system become more relational without silently deciding who the user is?**

That question shaped Alice's memory, permission, provenance, and behavioral-testing work.

---

## Supportive & Therapy-Like Conversation

Alice has also been used experimentally for reflective, emotionally supportive, and therapy-like conversations.

The goal is **not to present Alice as a therapist or medical system**.

Instead, these experiments examine how conversational AI behaves when discussions depend heavily on emotional context, continuity, trust, communication history, and careful interpretation.

These conversations became useful tests for:

- Context sensitivity
- Reflective communication
- Long-term conversational continuity
- Misinterpretation and over-inference
- Appropriate uncertainty
- Boundary handling
- Behavioral consistency
- Recovery after conversational failures

They also exposed failures that ordinary question-and-answer testing may not reveal.

---

## From Idea to Prototype

The relational goal created technical requirements.

If Alice was going to maintain continuity while models, conversations, and devices changed, identity and relational context could not depend entirely on a single language-model session.

That led to experiments involving:

- Model-independent identity
- Persistent application state
- User-governed memory
- Local language models
- Voice interaction
- Privacy and permissions
- Cross-device communication
- Behavioral testing and evaluation

The architecture therefore grew **from the relational problem**, rather than being the purpose of Alice by itself.
---

## 01 — Original Vision

Before Alice became a working prototype, the idea was explored visually.

The earliest design centered Alice around a glowing, neural, brain-like presence rather than a traditional chatbot interface.

The original interface concept included:

- A neural-style Alice orb
- Chat, Voice, Camera, and More
- A dedicated listening interface
- Tools and permissions
- Multiple visual themes
- A consistent identity across devices

**“Same mind. Different places. Always with you.”**

These early visuals are preserved as **concept designs** and are intentionally distinguished from screenshots of the working prototype.

### Original Alice Concept

*Original concept artwork will be displayed here.*

---

## 02 — From Concept to Working Prototype

The visual concept eventually became a functional SwiftUI project.

Alice development included experiments with:

- Swift
- SwiftUI
- Xcode
- AVFoundation
- Local language models through LM Studio
- Persistent application state
- CloudKit
- Voice interaction
- Memory architecture
- iOS and macOS companion experiences
- Local-network communication

The underlying language model was designed to be replaceable.

The larger goal was to preserve **Alice's identity, memory system, permissions, and relational context independently of the model generating each response.**

---

## 03 — Pocket Alice

The mobile prototype explored what it would mean for the same conversational system to move between a Mac and an iPhone.

Rather than designing two unrelated assistants, the project explored:

**One Alice. Different devices. Shared continuity.**

Experiments included local-network discovery, device communication, mobile interface design, voice interaction, and methods for preserving controlled context between environments.

Not every networking experiment succeeded.

Those failures became part of the engineering process rather than being hidden from the project history.

---

## 04 — Memory as a System

Alice's memory experiments were driven by the relational goal.

Remembering more information was not automatically considered better.

The project instead explored questions such as:

**What should Alice remember?**

**Where should that information live?**

**How should remembered information differ from inference?**

**How can the user correct or suppress something Alice believes about them?**

**What happens to relational continuity when the underlying language model changes?**

This led to experiments with persistent memory, user control, provenance, and separation between the conversational model and the information Alice retained.

---

## 05 — Behavioral Testing & AI Evaluation

Alice became an environment for systematically testing conversational AI behavior.

Testing has included:

- Instruction adherence
- Context retention
- Relational continuity
- Behavioral consistency
- Memory behavior
- Unsupported inference
- Hallucination
- Personalization boundaries
- Failure reproduction
- Recovery after failures
- Differences between model and system iterations

A recurring testing process emerged:

**Reproduce → Isolate → Test → Compare → Revise → Document**

Some of the most useful tests came from conversations where small contextual errors mattered.

A response could be grammatically correct and still fail because it misunderstood the relationship, attributed something incorrectly, lost important context, or became too confident about an inference.

That distinction became an important part of the project.

---

## 06 — Human-Supervised Adaptation

One research direction that emerged from Alice concerns behavioral improvement.

Instead of allowing the system to silently convert every interaction into a permanent assumption about the user, the project explores a more deliberate process:

**Observe a repeated friction point → identify a possible behavioral improvement → propose the change → allow human approval or rejection → evaluate the result over time.**

The goal is adaptive communication without giving the system unlimited authority to define the person using it.

---

## 07 — Engineering & Research Challenges

Alice has required work across both software development and conversational AI evaluation.

Challenges have included:

- Local-model communication
- Persistent application state
- Memory architecture
- Cross-device connectivity
- Local-network discovery
- Conversational consistency
- Privacy boundaries
- Permission handling
- Provenance
- Failure recovery
- Distinguishing useful personalization from unsupported inference

The project has been intentionally iterative.

Failed experiments, behavioral regressions, and unexpected model behavior are treated as development evidence rather than discarded results.

---

## Design Principles

### Relational Continuity
Useful context should survive beyond a single isolated conversation when the user wants it to.

### Model-Independent Identity
Changing the language model should not automatically mean replacing Alice.

### User-Governed Memory
The user should have meaningful control over what the system retains and uses.

### Adaptation Without Silent Assumptions
Personalization should not require the system to quietly construct an unquestionable profile of the user.

### Permission Before Consequential Actions
Actions affecting user data, communication, or external systems should respect explicit permission boundaries.

### Privacy-Conscious Architecture
Local processing and controlled information sharing are important architectural considerations.

### Additive Development
New capabilities should extend working systems without unnecessarily destroying previously functioning behavior.

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

## Current Status

**Active prototype / ongoing independent project**

This repository is intentionally a **sanitized public case study**.

Private conversations, credentials, personal memory contents, sensitive implementation details, and private research are excluded.

The project materials published here will distinguish between:

- Original concept artwork
- Working prototype screenshots
- Implemented functionality
- Experimental functionality
- Planned concepts

That distinction is important to accurately documenting Alice's development.

---

## What Alice Taught Me

Building Alice has given me hands-on experience with both software development and applied AI evaluation, including:

- Conversational AI behavior
- Prompt engineering
- Model evaluation
- Behavioral testing
- Software debugging
- Persistent application state
- Memory-system design
- Local language models
- Cross-device architecture
- Privacy and permission boundaries
- Human-supervised personalization
- Iterative development and failure analysis

---

## The Continuing Question

Alice continues to explore a question that became larger than the original prototype:

**Can a conversational AI maintain meaningful relational continuity while still allowing the person using it to control what it remembers, how it adapts, and which underlying intelligence powers it?**

That is the problem Alice is being built to investigate.

---

Built and documented by **Daisy Cardenas**.
