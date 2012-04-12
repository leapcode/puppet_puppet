class puppet::cron::freebsd inherits puppet::freebsd {

  include puppet::cron::base
  if $puppet_http_compression { $puppet_http_compression_str = '--http_compression' }

  if !$puppet_crontime {
    $puppet_crontime_interval_minute = fqdn_rand(29)
    $puppet_crontime_interval_minute2 = inline_template('<%= 30+puppet_crontime_interval_minute.to_i %>')
    $puppet_crontime = "${puppet_crontime_interval_minute},${puppet_crontime_interval_minute2} * * * *"
  }

  #TODO ensure that the service is disabled in /etc/rc.conf[.local]

  cron { 'puppetd_run':
    command => "/usr/local/bin/puppet agent --onetime --no-daemonize --config=${puppet::puppet_config} --color false $puppet_http_compression_str | grep -E '(^err:|^alert:|^emerg:|^crit:)'",
    user => 'root',
    minute => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\1'),','),
    hour => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\2'),','),
    weekday => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\3'),','),
    month => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\4'),','),
    monthday => split(regsubst($puppet_crontime,'^([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+) ([\d,\-,*,/,\,]+)$','\5'),',')
  }
}
