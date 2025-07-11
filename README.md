# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
1. Introduction (What & Why)
	"This project is a Participatory Budgeting System that allows citizens to propose and vote on budget initiatives within spending limits and voting phases. The admin can configure and monitor the process. It solves real-world budgeting constraints like phase-wise planning, budget category limits, and impact analysis."

2. System Overview
	Admin Panel:
		Built with ActiveAdmin

		Admin manages:

		Budgets

		Budget Categories (with % limits)

		Voting Phases (multi-phase logic)

		Budget Proposals

		Votes overview

		Impact Metrics of proposals

	User Panel:
		Users (citizens) can:

		View budget categories and their spending limit

		Submit new budget proposals

		Vote on proposals in active phases

		See utilization indicators

		Add impact assessments while submitting proposals

3. Features & Code Explanation
	A. Budget Category Limits & Spending Controls
		Admin sets spending_limit_percentage per category.

		During voting:

		System checks if the vote exceeds the remaining budget.

		If yes → voting is blocked.

		Utilization (%) = (Allocated / Allowed Budget) shown to users/admin.

		Code: budget_category.rb → methods like utilization_percentage, remaining_budget_for_category.

B. Multi-Phase Budget Voting
		Admin defines VotingPhase (e.g., Idea Phase, Final Voting).

		Each vote belongs to a voting_phase.

		Users can vote only during the active phase.

		Proposal filtering is phase-based.

		Code: voting_phase.rb, controller filters in votes_controller.rb, phase handling in views.

C. Budget Impact Assessment Integration
		When a user submits a proposal, they fill:

		estimated_beneficiaries

		timeline

		sustainability_score

		Admin can see this data in ActiveAdmin.

		Helps decision-making by showing expected impact.

		Code: impact_metric.rb, nested form in budget_proposals#new, impact views.

4. Demo Flow (Live Presentation)
		Admin Demo:
		Login to /admin

		Create:

		A new Budget (e.g., "City Budget 2025")

		Categories (e.g., Infrastructure - 40%)

		Voting Phases (e.g., Pre-Selection: July 1-10)

		Observe votes and utilization from dashboard.

		User Demo:
		Sign up as a user.

		View Budget Categories and % spent.

		Submit a new proposal with impact details.

		Vote on an existing proposal.

		See validation if limit exceeded or voting not allowed in current phase.
------------------------------------------------------------------------
# Participatory Budgeting System

This is a Ruby on Rails application for managing participatory budgeting, allowing citizens to propose and vote on budget ideas while enforcing category limits, supporting multi-phase voting, and tracking impact assessments.

---

## Features

### Budget Category Limits & Spending Controls
- Admin sets a `% limit` for each budget category (e.g. Infrastructure max 40%).
- Users cannot vote beyond the available category budget.
- Real-time validations and utilization shown.

### Multi-Phase Voting
- Voting is organized into **phases** (e.g., Idea Phase, Final Phase).
- Each vote belongs to a phase.
- Users can only vote in currently active phases.
- Admin can track votes phase-wise.

###  Impact Assessment Integration
- Users provide impact metrics when submitting proposals:
  - Estimated beneficiaries
  - Timeline
  - Sustainability score
- Admin and voters can use this data for decision-making and reporting.

---

| Layer        | Tech               |
|--------------|--------------------|
| Backend      | Ruby on Rails 7    |
| Database     | PostgreSQL         |
| Admin Panel  | ActiveAdmin        |
| Auth         | Devise             |
| Frontend     | Rails Views (ERB)  |

---

git clone https://github.com/your-username/participatory_budgeting.git
cd participatory_budgeting
2. Install dependencies

bundle install
3. Setup the database

rails db:create db:migrate db:seed
4. Start the server

rails server
5. Access the application
User Interface: http://localhost:3000

Admin Panel: http://localhost:3000/admin

Default admin:

Email: admin@example.com

