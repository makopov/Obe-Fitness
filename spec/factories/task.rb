FactoryBot.define do
    factory :task do
        title { 'My Task' }
        description { 'Task Description' }
        completed { false }
        due_date { Date.today + 1.week }
        priority { 'medium' }
        user
    end
end