require "landlady/version"
require "landlady/railtie" if defined? Rails

module Landlady
  extend self

  def default_search_path
    @default_search_path ||= %{"$user", public}
  end

  def set_search_path(name, include_public = true)
    path_parts = [name.to_s, ("public" if include_public)].compact
    ActiveRecord::Base.connection.schema_search_path = path_parts.join(",")
  end

  def restore_default_search_path
    ActiveRecord::Base.connection.schema_search_path = default_search_path
  end

  def create_schema(name)
    sql = %{CREATE SCHEMA "#{name}"}
    ActiveRecord::Base.connection.execute sql
  end

  def schemas
    sql = "SELECT nspname FROM pg_namespace WHERE nspname !~ '^pg_.*'"
    ActiveRecord::Base.connection.query(sql).flatten
  end

  class Tenant < ActiveRecord::Base

    has_and_belongs_to_many :admins

    validates :code, :subdomain, :name, :uniqueness => true

    after_create :prepare_tenant

    private

    def prepare_tenant
      create_schema
      load_tables
    end

    def create_schema
      Landlady.create_schema id unless Landlady.schemas.include? id
    end

    def load_tables
      return if Rails.env.test?
      Landlady.set_search_path id, false
      load "#{Rails.root}/db/schema.rb"
      ::Application::SHARED_TABLES.each { |name| connection.execute %{drop table "#{name}"} }
      Landlady.restore_default_search_path
    end

  end

end
