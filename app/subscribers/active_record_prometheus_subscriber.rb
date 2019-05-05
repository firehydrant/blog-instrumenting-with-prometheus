class ActiveRecordPrometheusSubscriber < ActiveSupport::Subscriber
  attach_to :active_record

  def sql(event)
    Prometheus.histograms['sql_queries_duration'].observe(event.duration, (Thread.current['metrics_labels'] || {}))
  end
end
