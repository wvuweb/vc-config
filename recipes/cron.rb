# Cron Recipe
# Run on a single instance

current_dir = ::File.join('/', 'srv', 'www', 'vc_admin', 'current')

cron "weekly report for vc_admin" do
  path "/usr/local/bin" # path to php
  weekday "1" # 0 - Sunday, 1 - Monday, 2 - Tuesday...
  hour "3" # Hour of the Day
  minute "30" # Minute of the Hour
  user "deploy"
  command "cd #{current_dir} && /usr/bin/php -r 'include \"cli/report.php\"; (new VisitorCenter\\Cli\\Report)->weekly();' > /dev/null 2>&1"
end

cron "grad_weekly report for vc_admin" do
  path "/usr/local/bin" # path to php
  weekday "1" # 0 - Sunday, 1 - Monday, 2 - Tuesday...
  hour "3" # Hour of the Day
  minute "35" # Minute of the Hour
  user "deploy"
  command "cd #{current_dir} && /usr/bin/php -r 'include \"cli/report.php\"; (new VisitorCenter\\Cli\\Report)->grad_weekly();' > /dev/null 2>&1"
end
