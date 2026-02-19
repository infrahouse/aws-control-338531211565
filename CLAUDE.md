# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## First Steps

**Your first tool call in this repository MUST be reading .claude/CODING_STANDARD.md.
Do not read any other files, search, or take any actions until you have read it.**
This contains InfraHouse's comprehensive coding standards for Terraform, Python, and general formatting rules.

## Repository Overview

This is an AWS control repository for AWS account **338531211565**. It is an infrastructure-as-code
repository using Terraform to manage AWS resources for this specific account.

The repository follows the InfraHouse `aws-control-*` naming pattern where each AWS account has its
own control repository.

## Key Files

- `.claude/CODING_STANDARD.md` — InfraHouse coding standards (managed by github-control, do not edit)
- `.github/workflows/vuln-scanner-pr.yml` — OSV vulnerability scanning on PRs (managed by github-control)
- `renovate.json` — Renovate bot config for dependency updates (concurrent PR limit: 1)

## Terraform Conventions

- InfraHouse modules use `registry.infrahouse.com` (not the public Terraform registry)
- All module versions must be pinned exactly (no `~>` ranges); Renovate handles updates
- Use `snake_case` for all Terraform identifiers; lowercase tags except `Name`
- IAM policies must use `aws_iam_policy_document` data sources, never inline JSON
- Secrets go through the `infrahouse/secret/aws` module
- File organization: at minimum `main.tf`, `variables.tf`, `outputs.tf`; split further by function
- Validation blocks must use ternary operators for nullable variables (not logical OR)

## Managed Files

Several files in this repo are managed by Terraform in the
[github-control](https://github.com/infrahouse8/github-control) repository. Do not edit them directly;
changes will be overwritten. These include `.claude/CODING_STANDARD.md` and `.github/workflows/*.yml`.