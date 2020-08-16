require 'csv'
require 'open-uri'

desc 'Import CSVs with business data into Projects table'
#example command: rake import_csv['https://a_csv.csv','A project type']
task :import_csv, [:path, :tag] => :environment do |task, args|
  csv_text = open(args[:path])
  csv = CSV.parse(csv_text, :headers=>true)
  csv.each do |row|
  	converted_row = row.to_hash
  	converted_row[:project_type_list] = [ args[:tag] ]
  	Project.create!(converted_row)
  end
end



