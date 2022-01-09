# aliyun sls
# logtail
cat /usr/local/ilogtail/ilogtail_config.json
cat /usr/local/ilogtail/app_info.json
/etc/init.d/ilogtaild stop && /etc/init.d/ilogtaild start
/etc/init.d/ilogtaild status

# logsearch data analysis
* | select date_format(__time__, '%H:%i') as t, count(1) as pv group by t order by t
* | select time_series(__time__, '1m', '%H:%i', '0') as t, count(1) as pv group by t order by t
* | select time_series(__time__, '1m', '%H:%i', 'last') as t, count(1) as pv group by t order by t
* | select time_series(__time__, '1m', '%H:%i', 'next') as t, count(1) as pv group by t order by t
* | SELECT COUNT(*) as pv, date_format(__time__, '%Y-%m-%d') as t GROUP BY t

* | select t, diff[1] as "today", diff[2] as "yesterday" from (select t, ts_compare(pv, 604800) as diff from(select date_trunc('minute', __time__) as t, count(1) as pv from log group by t) group by t)

* | select regexp_extract(url, '(k0)=([^&]+)', 2), url_extract_parameter(url, 'k0')
* | select json_extract(content, '$.k1.k2')

* | select remote_addr, ip_to_province(remote_addr), ip_to_city(remote_addr), ip_to_provider(remote_addr), ip_to_geo(remote_addr)
* | select ip_to_province(remote_addr) as province, count(1) as pv group by province

* | select *, pv*1.0/province_pv as percent, pv*1.0/total, province_pv*1.0/total from (select *, sum(pv) over(partition by province) as province_pv, sum(pv) over() as total from (select ip_to_province(remote_addr) as province, ip_to_city(remote_addr) as city, count(1) as pv group by province, city))

* | select approx_distinct(remote_addr), approx_percentile(remote_addr, 0.5), approx_percentile(remote_addr, 0.99), avg(request_time)
* | select distinct remote_addr from log limit 1, 10
* | select count(1) from log l join ip_data d on l.remote_addr = d.ip

* and request_uri : searchArticle | SELECT url, count(1) as ct from (select url_extract_parameter(request_uri, 'KEYWORDS') as url from log) group by url order by ct desc limit 1000
* and request_uri : searchArticle | select time_series(__time__, '1m', '%H:%i', '0') as t, count(1) as pv group by t order by t limit 1500
* and request_uri : searchArticle | select t, diff[1] as current, diff[2] as yestoday, diff[3] as percentage from(select t, compare( pv , 86400) as diff from (select count(1) as pv, date_format(from_unixtime(__time__), '%H:%i') as t from log group by t) group by t order by t) s limit 1500
* and request_uri : searchArticle  | select ip_to_province(client_ip) ip, count(1) as pv group by ip order by pv desc 
* and request_uri : searchArticle | select client_ip, ip_to_country(client_ip) as country, ip_to_provider(client_ip) as provider, count(1) as PV where security_check_ip(client_ip) = 1 group by client_ip order by PV desc
request_uri : searchArticle | select request_uri FROM log WHERE request_uri LIKE '%97/%E7%/?' escape '/'