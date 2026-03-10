Process a large or unstructured input — organise it, confirm understanding, and hold before taking action.

Use this when the user says "don't do anything yet", "just confirm", "come back to me", or gives a large unstructured input (voice transcript, review feedback, stream of thoughts, instructions) and wants organised processing before action.

## Input

$ARGUMENTS

## Instructions

1. **Identify all threads.** Read the full input and extract every distinct topic, decision, question, instruction, and action item. Don't merge things that are separate — keep the granularity.

2. **Organise into categories.** Group the extracted items under clear headings. Use whatever categories fit the input — common ones include:
   - **Decisions** — things that have been decided
   - **Action items** — things that need doing
   - **Questions** — things that need answering before work can start
   - **Context** — background information, constraints, preferences
   - **Open threads** — ideas raised but not resolved

3. **Flag certainty levels.** For each item, indicate whether it's:
   - **Nailed down** — clear, unambiguous, ready to act on
   - **Needs clarification** — intent is apparent but details are missing or ambiguous
   - **Open** — raised but not decided; needs discussion

4. **Suggest an order.** Based on dependencies and priorities, suggest what order to tackle things in. Flag any blockers — items that must be resolved before others can proceed.

5. **Confirm back.** Present the organised summary to the user. Be direct — "Here's what I've got" not "I'd like to confirm my understanding."

6. **Ask about logging.** Ask whether a /log should be taken of the input and decisions — especially useful for voice transcripts or lengthy planning sessions that would otherwise be lost.

## Rules

- **Do not take any action.** No file creation, no edits, no code changes, no commits. This skill is read-only.
- UK English throughout
- No emojis
- Bullet points with bold leads for scannability
- If the input is short or already well-structured, say so — don't force unnecessary processing
- If the input contains contradictions, call them out explicitly
