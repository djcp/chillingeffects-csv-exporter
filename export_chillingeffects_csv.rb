require './lib/csv_exporter.rb'

ENV['mysql_host'] ||= 'localhost'
ENV['mysql_port'] ||= '3306'
ENV['mysql_username'] ||= 'chill_user'
ENV['mysql_password'] ||= 'chill_pass'
ENV['mysql_database'] ||= 'chill_prod'

exporter = CsvExporter.connect


notice_sql = %q|select tNotice.*, group_concat(tNotImage.Location) as OriginalFilePath
from tNotice, tNotImage
where tNotice.NoticeID = tNotImage.NoticeID
group by tNotice.NoticeID limit 10000|

exporter.write_csv(notice_sql, 'tmp/tNotice.csv')
