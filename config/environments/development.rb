Rails.application.configure do

  config.cache_classes = false


  config.eager_load = false

  config.consider_all_requests_local = true

  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options)
  config.active_storage.service = :local

  # Don"t care if the mailer can"t send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :test
  host = "localhost:3000"
  config.action_mailer.default_url_options = { host: host, protocol: "http" }
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      port: 587,
      authentication: 'plain',
      user_name: ENV["GMAIL_USERNAME"],
      password: ENV["GMAIL_PASSWORD"],
      enable_starttls_auto: true
  }  
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
