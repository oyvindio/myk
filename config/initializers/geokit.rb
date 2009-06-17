#getting keys for google map
case RAILS_ENV
  when 'development' || 'test'
    GOOGLE_APPLICATION_ID = "ABQIAAAAnpvA24-2w5ni_ZKJ0JD1jBTJQa0g3IQ9GZqIMmInSLzwtGDKaBTXnShJYAYT_mVAtbv0Z_JJShaCwQ"
  when 'production'
    GOOGLE_APPLICATION_ID ="ABQIAAAAnpvA24-2w5ni_ZKJ0JD1jBSjnQjNWzJhDLbA6TFeFXnHLMYsOhRNwvnYWtH2CSPcEUCEaO71O-WGGQ"
end
