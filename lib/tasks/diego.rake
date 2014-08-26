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
  desc "Creates an admin user"
  task :create_admin => :environment do
    user = User.find_or_create_by_username_and_role('Admin', 'admin')
    user.email = 'admin@mootelos.com'
    user.password = 'Admin.1234'
    user.password_confirmation = 'Admin.1234'
    if user.save
      p "Admin user has been created."
    else
      p "ERROR!!!"
      p user.errors.inspect
    end
  end
end