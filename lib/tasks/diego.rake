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
  desc "completes users password token"
  task :users_password_token => :environment do
    users = User.where('users.reset_password_token IS NULL')
    users.each do |user|
      user.reset_password_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless User.exists?(reset_password_token: random_token)
      end
      if user.save
        p "User: #{user.username} updated"
      else
        p "User: #{user.username} fails"
      end
    end
    users = User.where('users.remember_token IS NULL')
    users.each do |user|
      user.remember_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless User.exists?(remember_token: random_token)
      end
      if user.save
        p "User: #{user.username} updated"
      else
        p "User: #{user.username} fails"
      end
    end
  end

  desc "Creates a group of specialties"
  task :add_specialties => :environment do
    sp1  = Specialty.find_or_create_by_name('Jacuzzi')
    sp2  = Specialty.find_or_create_by_name('Espejos')
    sp3  = Specialty.find_or_create_by_name('Luz ambiental')
    sp4  = Specialty.find_or_create_by_name('Decoracion con velas')
    sp5  = Specialty.find_or_create_by_name('Decoracion con petalos de rosas')
    sp6  = Specialty.find_or_create_by_name('Fondue')
    sp7  = Specialty.find_or_create_by_name('Globos')
    sp8  = Specialty.find_or_create_by_name('Minibar')
    sp9  = Specialty.find_or_create_by_name('Cama duplex')
    sp10 = Specialty.find_or_create_by_name('Telefono')
  end

end