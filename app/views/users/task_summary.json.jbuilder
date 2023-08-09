json.array! @summary do |row|
    json.priority_level row.priority_level
    json.completed_tasks row.completed_tasks
    json.incomplete_tasks row.incomplete_tasks
end
  