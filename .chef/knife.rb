# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "bommara"
client_key               "#{current_dir}/bommara.pem"
validation_client_name   "ubunt-validator"
validation_key           "#{current_dir}/ubunt-validator.pem"
chef_server_url          "https://api.chef.io/organizations/ubunt"
cookbook_path            ["#{current_dir}/../cookbooks"]
