namespace :diego do
  desc 'Define roles for users'
  task(:user_roles => :environment) do
    users = User.all
    users.each do |user|
      if user.hotels.count > 0 && !user.role?
        user.update_attribute :role, "hotel"
        p "user #{user.id} updated"
      end
    end
  end
end