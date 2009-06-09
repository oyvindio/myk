desc "Todos after installing this plugin"
namespace :roleify do
  task :whattodo do
    puts "1) Add this to user model"
    puts "          has_and_belongs_to_many :roles"
    puts "          include RoleifyModelStuff"
  
    puts "2) Add this to user controller"
    puts"           before_filter :check_administrator_role,:only=>[:index,:destroy]"
  
    puts "3) Add this to application controller"
    puts"           include RoleifySystem"
    
    puts "4) Add this to your routes"
    puts"       map.resources :users,:has_many=>:roles"
    
    
    puts "5) run rake roleify:sync it copies the migration files"
    
  end
end

namespace :roleify do
  task :sync do
    system ('cp vendor/plugins/roleify/db/migrate/* db/migrate/')
  end
end
