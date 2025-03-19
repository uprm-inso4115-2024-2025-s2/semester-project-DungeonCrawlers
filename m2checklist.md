This checklist includes both the professor's feedback and the milestone 2 guidelines.  

***The documentation must comply with each and every point in here!***

## 1. Informative Part

### 1.1 Team
- [ ] Justification for the absence of external partners is explicitly stated, or external partners are included.

### 1.2.1 Current Situation
- [X] Specific data or surveys are cited to support claims in the project.

### 1.2.2 Needs
- [ ] The needs in the project are validated with clear justification (e.g., consensus among project members or surveys).

### 1.3 Scope, Span, and Synopsis
- [X] Non-coding activities (e.g., domain acquisition, stakeholder engagement) are explicitly outlined and detailed.

### 1.4 Other Activities Outside of Developing Source Code
- [X] Plans for domain acquisition (e.g., interviews, surveys) and stakeholder engagement are explicitly outlined.

### 1.5 Derived Goals
- [ ] Derived goals go beyond the primary goals and are well-explained.

---

## 2. Descriptive Part

### 2.1 Domain Description
- [ ] Domain functions are more thoroughly described, especially beyond basic concepts like player movement.
- [ ] The relationship between enemy and NPC is clarified and defined.
- [ ] Clear definitions are provided for actions, events, and behaviors, specifying how each operates and relates to others.

#### 2.1.1 Domain Rough Sketch
- [ ] Terminology is validated, ensuring concepts like "rooms" and "corridors" are used consistently, or simplified.

#### 2.1.2 Terminology
- [ ] The terminology section includes not just entities but also actions, events, and behaviors.

#### 2.1.4 Domain Narrative
- [ ] The event "Loot Discovery" is clearly defined, identifying what constitutes the event and how it differs from actions.

#### 2.1.5 Events, Actions, and Behaviors
- [ ] Distinctions between actions and events are clearly outlined and correctly described.
- [ ] Time-dependent events (e.g., "enemies are created and killed") are accurately represented as events or behaviors.
- [ ] The distinction between actions and events in the project is reviewed and corrected where necessary.
- [X] Function signatures are integrated into action/operation descriptions, not kept in separate sections.
- [ ] Functions align with their descriptions. For example, if "move" checks for collisions, it should reflect that in the function.
- [X] The relationship between the attack and dodge functions is clearly defined.
- [X] The role of the enemy and conditions in functions like `revive` is clarified.
- [X] `InteractionResult` is replaced by boolean

### 2.2 Requirements
- [ ] The requirements are connected to the epics clearly.

#### 2.2.2 Personas
- [X] Personas are vividly described with detailed background and goals.

#### 2.2.3 Domain Requirements
- [ ] Requirements are clearly defined, measurable, and specific (e.g., avoid vague terms like "party option").
- [ ] Domain requirements are fine-grained, not merely feature descriptions.

#### 2.2.4 Interface Requirements
- [ ] Specific points like collision shapes and sprites are explained in terms of how they aid the development.

#### 2.2.5 Machine Requirements
- [ ] Walkthroughs or other validation methods for requirements are included to ensure the system meets the intended goals.


## 3. Analytic Part

### 3.1 Concept Analysis
- [ ] Inconsistencies are analyzed for specific types of clashes.
- [ ] At least five weak inconsistencies are included, along with the boundary conditions that make them inconsistent.
- [ ] Competing goals are identified, with examples of derived requirements.

### 3.2 Validation and Verification
- [ ] The special class topics from the testing course should be related to the requirements course.
- [ ] Evaluation criteria are developed with team input.
- [ ] Requirements are prioritized using team input, and AHP (Analytic Hierarchy Process) is applied (e.g., using the [AHP tool on GitHub](https://github.com/gluc/ahp)).
- [ ] At least three example requirements are discussed in terms of satisfiability and feasibility.

---

## 4. Specific Class Topics

### Stakeholder Identification
- [ ] Initial stakeholders are identified based on domain, requirements, usage scenarios, and growth trajectories.
- [ ] Each stakeholder’s relevance to the project is explained.
- [ ] A plan is outlined for identifying additional stakeholders.
- [ ] Resources for finding more stakeholders are identified.
- [ ] A method for integrating additional stakeholder perspectives into the project is established.

### Personas
- [ ] Personas are created for relevant stakeholder groups.
- [ ] Personas cover different aspects of the project (e.g., domain personas, requirement personas, users, hosting company employees).
- [ ] More important stakeholder groups have detailed personas.

### Domain and Requirements Acquisition
- [X] A specific plan for domain and requirements acquisition is outlined.
- [X] The plan includes more than generic activities (e.g., consulting relevant literature, conducting interviews).
- [ ] The plan explains how meaningful requirements will be documented.
- [X] Relevant resources are identified, with justification for their inclusion.
- [X] A strategy for incorporating new findings into domain understanding is outlined.
- [X] The plan includes diverse resources (e.g., stakeholders, literature).

### Traceability
- [ ] The project deliverables are designed to support traceability.
- [ ] Methods for tracking requirement changes and their impact on high-level goals are implemented.
- [ ] Requirements are linked to goals, personas, and validation processes.
- [ ] Tests are linked to requirements through traceability methods (e.g., tagging requirements in test source code).
- [ ] The team demonstrates how traceability is achieved within their documentation.
- [ ] At least some of the following traceability questions can be answered using project deliverables:
  - [ ] Which domain concepts are linked to a given requirement?
  - [ ] Where is the domain property described that gives rise to a requirement?
  - [ ] Which user stories or epics relate to this requirement?
  - [ ] Which tests are associated with the requirement?
  - [ ] In which validation activities was this requirement verified?
  - [ ] What is the current state of test coverage for this requirement?

### Inconsistencies and Resolutions
- [ ] Several candidate resolutions for inconsistencies are generated.
- [ ] At least three cases of further elicitation used to reach candidate resolutions.
- [ ] At least three cases where resolution tactics were applied.

### Risk Management
- [ ] At least three risks identified using FMEA (Failure Modes and Effects Analysis).
- [ ] At least three risks identified using guidewords, with risks generated for each.
- [ ] Risks are assessed with justification/discussion.

### Risk Countermeasures
- [ ] At least three risks with candidate countermeasures generated, some using risk reduction tactics.