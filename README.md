# Family Tree Scheme Project

## Table of Contents
1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [How to Run the Program](#how-to-run-the-program)
5. [Summary](#summary)

## Project Overview

This project implements a **Family Tree System** in the **Scheme** programming language, developed in pair. 
It models maternal and paternal branches of a family and provides multiple functions to process, query, and manipulate family data such as:

- Listing all members in both branches  
- Identifying parents and children  
- Calculating ages and average ages at death  
- Sorting and filtering by names and birthdays  
- Modifying records (e.g., changing a person’s name)

The program demonstrates recursion, higher-order functions, list processing, and functional programming techniques in Scheme.

---

## Features

The system provides the following functions:

| Feature | Description |
|---------|-------------|
| **C1** | List all members in the Maternal Branch. |
| **C2** | List all members in the Paternal Branch. |
| **C3** | List all members in both branches combined. |
| **A1** | List all parents from a branch. |
| **A2** | List living members of a branch. |
| **A3** | Calculate current age of living members. |
| **A4** | Find members with birthdays in a specific month. |
| **A5** | Sort members by last name. |
| **A6** | Change the first name of a member. |
| **B1** | List children of members in a branch. |
| **B2** | Find the oldest living member in a branch. |
| **B3** | Calculate the average age at death of members. |
| **B4** | Find members with birthdays in a specific month (branch-specific). |
| **B5** | Sort members by first name. |
| **B6** | Change a person’s first name recursively in the branch. |

---

## Technologies Used
- **Language:** Racket / Scheme (`.rkt` file)
- **Paradigm:** Functional programming
- **Main Concepts:** Recursion, list processing, higher-order functions, and data abstraction

---

## How to Run the Program

Navigate to the project directory:

```bash
cd family-tree-scheme
```
Run the main file using Racket:

```bash
racket family_tree_code.rkt
```
## Summary

This project demonstrates functional programming and data abstraction through a detailed implementation of a family tree system in Scheme.  
It allows exploration of relationships, sorting, filtering, and data manipulation entirely using recursive and declarative techniques.

