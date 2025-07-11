puts "Seeding..."

# Clear old data
Vote.delete_all
ImpactMetric.delete_all
BudgetProposal.delete_all
BudgetCategory.delete_all
VotingPhase.delete_all
User.delete_all
Budget.delete_all

# Create Admin
admin = AdminUser.create!(
  email: "admin@example.com",
  password: "password"
)
puts "Admin created"

# Create Users
alice = User.create!(name: "sumit", email: "alice@example.com", password: "password", role: "user")
bob   = User.create!(name: "antim", email: "bob@example.com", password: "password", role: "user")

users = [alice, bob]
puts "Users created"

# Create Budget
budget = Budget.create!(name: "FY 2025", total_amount: 500_000)
puts "Budget created"

# Create Budget Categories
categories = BudgetCategory.create!([
  { name: "Infrastructure", spending_limit_percentage: 40, budget: budget },
  { name: "Healthcare",     spending_limit_percentage: 30, budget: budget },
  { name: "Education",      spending_limit_percentage: 20, budget: budget },
  { name: "Environment",    spending_limit_percentage: 10, budget: budget }
])
puts "Budget categories created"

# Add Proposals with Impact Metrics
categories.each do |category|
  2.times do |i|
    proposal = category.budget_proposals.create!(
      title: "#{category.name} Project #{i+1}",
      amount: rand(20_000..50_000),
      user: users.sample
    )

    proposal.create_impact_metric!(
      estimated_beneficiaries: rand(500..5000),
      timeline: "#{rand(3..12)} months",
      sustainability_score: rand(1..10)
    )
  end
end
# Create Voting Phases

VotingPhase.create!([
  { name: "Idea Phase", start_date: 1.week.ago, end_date: 2.days.ago, voting_rule: "single_vote", status: "ended" },
  { name: "Final Voting", start_date: 1.day.ago, end_date: 7.days.from_now, voting_rule: "multi_vote", status: "active" }
])

puts "Voting phases created"

# Optional: Cast sample votes
active_phase = VotingPhase.find_by("start_date <= ? AND end_date >= ?", Time.current, Time.current)

if active_phase
  users.each do |user|
    random_proposal = BudgetProposal.order("RANDOM()").first
    Vote.create!(
      user: user,
      budget_proposal: random_proposal,
      voting_phase: active_phase,
      amount: rand(5_000..10_000)
    )
  end
  puts "Sample votes cast"
else
  puts "No active phase, skipping votes"
end

