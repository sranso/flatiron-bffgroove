every 1.hours do
  rake "download"
  rake "import"
  command "rm -rf #{RAILS_ROOT}/main.csv"
end