require "rails/railtie"
module Landlady
  class Railtie < Rails::Railtie

    initializer "Landlady.handle_subdomains" do
      ActiveSupport.on_load(:action_controller) do 
        Landlady.set_search_path(@tenant.id) if @tenant = Landlady::Tenant.find_by_subdomain(request.subdomain)
      end
    end

    rake_tasks do
      load "tasks/tenants.rake"
    end

  end
end
