namespace :tenants do
  namespace :db do
    desc "runs db:migrate on each tentant's private schema"
    task :migrate => :environment do
      verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migration.verbose = verbose

      Tenant.all.each do |tenant|
        puts "Migrating tenant #{tenant.id} (#{tenant.subdomain})"
        Landlady.set_search_path tenant.id, false
        version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
        ActiveRecord::Migrator.migrate("db/migrate/", version)
      end
    end
  end
end