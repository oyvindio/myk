# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_myk_session',
  :secret      => 'e066c39c5e154f3c5d6ce9933e8f8e7b8967c838de5b26f8e7b94542cb5cf6e37c058257fe8acb5e2504ca85dd11586fdc76204a233eb6f126227802447c2e67'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
