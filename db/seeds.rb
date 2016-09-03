project = Project.new name: 'Mini Shop', description: 'A simple online shopping store'

state = OptionField.new name: 'State'
state.options << Option.new(name: 'Open')
state.options << Option.new(name: 'Closed')

status = OptionField.new name: 'Status'
status.options << Option.new(name: 'No Activity')
status.options << Option.new(name: 'In Progress')
status.options << Option.new(name: 'Test & Review')
status.options << Option.new(name: 'Completed')

type = OptionField.new name: 'Type'
type.options << Option.new(name: 'Feature')
type.options << Option.new(name: 'Bug')
type.options << Option.new(name: 'Enhancement')
type.options << Option.new(name: 'Invalid')

priority = OptionField.new name: 'Priority'
priority.options << Option.new(name: 'High')
priority.options << Option.new(name: 'Medium')
priority.options << Option.new(name: 'Low')

version = StringField.new name: 'Version'
start_date = DateTimeField.new name: 'Start Date'
complete_date = DateTimeField.new name: 'Complete Date'

project.fields << state << status << type << priority << version << start_date << complete_date
project.save!

oc = OrClause.new
oc.conditions << Equal.new(field: state, value: state.options.find_by(name: 'Open').id)
oc.conditions << Equal.new(field: status, value: status.options.find_by(name: 'No Activity').id)

ac = AndClause.new
ac.conditions << Equal.new(field: type, value: type.options.find_by(name: 'Bug').id)
ac.conditions << Equal.new(field: priority, value: priority.options.find_by(name: 'High').id)
ac.clauses << oc
ac.save!

q = Query.new
q.project = project
q.criterion = ac
q.save!

acr = AndClause.new
acr.conditions << Equal.new(field: state, value: state.options.find_by(name: 'Closed').id)
acr.conditions << NotEqual.new(field: complete_date, value: nil)

r1 = project.rules.new
r1.prerequisite = Equal.new(field: status, value: status.options.find_by(name: 'Completed').id)
r1.assertion = acr
r1.save!

r2 = project.rules.new
r2.prerequisite = NotEqual.new(field: status, value: status.options.find_by(name: 'No Activity').id)
r2.assertion = NotEqual.new(field: start_date, value: nil)
r2.save!

r3 = project.rules.new
r3.assertion = NotEqual.new(field: version, value: nil)
r3.save!

total = 5000
current = 0
while current < total
  issue = project.issues.new
  issue.name = ['Test Name 1', 'Test Name 2', 'Test Name 3', 'Test Name 4', 'Test Name 5', 'Test Name 6', 'Test Name 7'].sample
  issue[state] = state.options.sample.id
  issue[status] = status.options.sample.id
  issue[type] = type.options.sample.id
  issue[priority] = priority.options.sample.id
  issue[version] = ['0.1.0', '0.2.0', '0.3.0', '0.4.0'].sample
  issue[start_date] = (@start_dates ||= [5.days.ago, 4.days.ago, 3.days.ago, 2.days.ago, 1.days.ago]).sample
  issue[complete_date] = (@complete_dates ||= [1.weeks.from_now, 2.weeks.from_now, 3.weeks.from_now, 4.weeks.from_now, nil]).sample

  current += 1 if issue.save
end
