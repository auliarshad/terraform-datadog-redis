locals {
  monitor_enabled = "${var.enabled && length(var.recipients) > 0 ? 1 : 0}"
}

resource "datadog_timeboard" "redis" {
  title       = "${var.product_domain} - ${var.cluster} - ${var.environment} - Redis"
  description = "A generated timeboard for Redis"

  template_variable {
    default = "${var.cluster}"
    name    = "cluster"
    prefix  = "name"
  }

  template_variable {
    default = "${var.environment}"
    name    = "environment"
    prefix  = "environment"
  }

  graph {
    title     = "Bytes Used for Cache"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.bytes_used_for_cache{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Cache Hits"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.cache_hits{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Cache Misses"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.cache_misses{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "CPU Utilization"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.cpuutilization{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Curr Connections"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.curr_connections{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Curr Items"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.curr_items{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Evictions"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.evictions{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Freeable Memory"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.freeable_memory{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Get Type Cmds"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.get_type_cmds{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Network Bytes In"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.network_bytes_in{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Network Bytes Out"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.network_bytes_out{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "New Connections"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.new_connections{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Reclaimed"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.reclaimed{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Replication Bytes"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.replication_bytes{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Replication Lag"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.replication_lag{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Save in Progress"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.save_in_progress{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Sorted Set Based Cmds"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.sorted_set_based_cmds{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Set Type Cmds"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.set_type_cmds{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Sorted Set Based Cmds"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.sorted_set_based_cmds{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }

  graph {
    title     = "Swap Usage"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.swap_usage{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Is Master"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.is_master{$cluster} by {cacheclusterid}"
      type = "area"
    }
  }

  graph {
    title     = "Geo Spatial Based Cmds"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:aws.elasticache.geo_spatial_based_cmds{$cluster} by {cacheclusterid}.as_count()"
      type = "area"
    }
  }
}

module "monitor_free_memory" {
  source  = "github.com/traveloka/terraform-datadog-monitor"
  enabled = "${local.monitor_enabled}"

  product_domain = "${var.product_domain}"
  service        = "${var.service}"
  environment    = "${var.environment}"
  tags           = "${var.tags}"
  timeboard_id   = "${join(",", datadog_timeboard.redis.*.id)}"

  name               = "${var.product_domain} - ${var.cluster} - ${var.environment} - Free Memory is Low"
  query              = "sum(last_5m):avg:aws.elasticache.freeable_memory{name:${var.cluster}} by {cacheclusterid,accountname} <= ${var.free_mem_thresholds["critical"]}"
  thresholds         = "${var.free_mem_thresholds}"
  message            = "${var.free_mem_message}"
  escalation_message = "${var.free_mem_escalation_message}"

  recipients         = "${var.recipients}"
  alert_recipients   = "${var.alert_recipients}"
  warning_recipients = "${var.warning_recipients}"

  renotify_interval = "${var.renotify_interval}"
  notify_audit      = "${var.notify_audit}"
}
