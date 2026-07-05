Describe the current change using `jj describe`. Write a description that will become a permanent part of version control history.

## Before Writing: Inspect the Change

Always examine the change thoroughly before writing a description:

1. **Check status and file list:**
   ```bash
   jj st                    # Show changed files
   jj diff --stat           # Summary with line counts
   ```

2. **Review the actual diff:**
   ```bash
   jj diff                  # Full diff of current change
   jj diff path/to/file.go  # Diff for specific file
   ```

3. **For changes on other revisions:**
   ```bash
   jj diff -r <revision>    # Diff for a specific revision
   jj log --limit 5         # See recent changes with descriptions
   ```

4. **Cross-reference with context:**
   - Review the conversation history to understand *why* changes were made
   - Note any design decisions, trade-offs, or rejected alternatives discussed
   - Identify the problem that prompted the change
   - If you made the changes, recall the motivation and approach

5. **Read key files if needed:**
   - If the diff is large, read specific files to understand the pattern
   - Look for related changes that form a cohesive unit

The goal is to understand both *what* changed and *why* before summarizing.

## What Makes a Good Description

A change description communicates:
1. **What** change is being made (summarize so readers understand without reading the full diff)
2. **Why** the change is being made (context, decisions not reflected in code, motivation)

Future developers will search for this change based on its description. Source code reveals what software does, but not why it exists. A good description helps future engineers understand whether they can safely modify this code.

## First Line

- Short summary of what is being done
- Complete sentence, written as an imperative (order)
- Should stand alone for readers skimming history
- Followed by a blank line

Example: "Delete the FizzBuzz RPC and replace it with the new system."
Not: "Deleting the FizzBuzz RPC and replacing it with the new system."

## Body

The body should include:
- Brief description of the problem being solved
- Why this is the best approach
- Any shortcomings or trade-offs
- Background context (bug references, design decisions, benchmark results)
- Enough context that future readers can understand without external links

Use bullet points for multiple discrete changes.

## Bad Descriptions

These are too vague:
- "Fix bug"
- "Fix build"
- "Add patch"
- "Moving code from A to B"
- "Phase 1"
- "Add convenience functions"

## Good Examples

**Functionality change:**
```
Remove size limit on RPC server message freelist

Servers like FizzBuzz have very large messages and would benefit from reuse.
Make the freelist larger, and add a goroutine that frees entries slowly over
time, so that idle servers eventually release all freelist entries.
```

**Refactoring:**
```
Construct Task with TimeKeeper to use its TimeStr and Now methods

Add a Now method to Task so the borglet() getter can be removed (which was
only used by OOMCandidate to call borglet's Now method). This replaces the
methods on Borglet that delegate to a TimeKeeper.

Allowing Tasks to supply Now is a step toward eliminating the dependency on
Borglet. Eventually, collaborators should use a TimeKeeper directly, but this
accommodates refactoring in small steps.
```

**Small change needing context:**
```
Create a Python3 build rule for status.py

This allows consumers already using Python3 to depend on a rule next to the
original status build rule instead of somewhere in their own tree. It
encourages new consumers to use Python3 and simplifies automated build file
refactoring tools being worked on currently.
```

**With bullet points:**
```
Migrate ops layer to typed errs package

- Convert all ops files to use errs.AsNotFound(), errs.AsValidation(), etc.
- Add public messages and context to errors for better user feedback
- Update error handling migration spec with progress

This standardizes error handling across the ops layer, giving handlers
structured errors they can use to show appropriate messages to users.
```
