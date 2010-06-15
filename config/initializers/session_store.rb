# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_amazon_search_example_session',
  :secret      => '3101052280fcc378f64b9e4d844d19ad8a813ae5f199fad8fb38f7348ded1b809b66b9d75a818f462899201187e4abab2023c56ac6c9779f5048129d7de3b6af'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
