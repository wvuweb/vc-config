# Cron Recipe
# Run on a single instance

vcadmin_dir = ::File.join('/', 'srv', 'www', 'vc_admin', 'current')
cron "weekly report for vc_admin" do
  path "/usr/local/bin" # path to php
  weekday "1" # 0 - Sunday, 1 - Monday, 2 - Tuesday...
  hour "3" # Hour of the Day
  minute "30" # Minute of the Hour
  user "deploy"
  command "cd #{vcadmin_dir} && /usr/bin/php -r 'include \"cli/report.php\"; (new VisitorCenter\\Cli\\Report)->weekly();' > /dev/null 2>&1"
end

cron "grad_weekly report for vc_admin" do
  path "/usr/local/bin" # path to php
  weekday "1" # 0 - Sunday, 1 - Monday, 2 - Tuesday...
  hour "3" # Hour of the Day
  minute "35" # Minute of the Hour
  user "deploy"
  command "cd #{vcadmin_dir} && /usr/bin/php -r 'include \"cli/report.php\"; (new VisitorCenter\\Cli\\Report)->grad_weekly();' > /dev/null 2>&1"
end

appstatus_dir = ::File.join('/', 'srv', 'www', 'appstatus', 'current')
cron "fetch data for appstatus" do
  path "/usr/local/bin" # path to php
  weekday "*" # 0 - Sunday, 1 - Monday, 2 - Tuesday...
  hour "9" # Hour of the Day
  minute "0" # Minute of the Hour
  user "deploy"
  command "cd #{appstatus_dir} && /usr/bin/php console/console --fetch > /dev/null 2>&1"
end

cron "load data for appstatus" do
  path "/usr/local/bin" # path to php
  weekday "*" # 0 - Sunday, 1 - Monday, 2 - Tuesday...
  hour "9" # Hour of the Day
  minute "5" # Minute of the Hour
  user "deploy"
  command "cd #{appstatus_dir} && /usr/bin/php console/console --import > /dev/null 2>&1"
end
