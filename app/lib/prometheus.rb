require 'prometheus_exporter/client'

class Prometheus
  include Singleton

  def client
    @client ||= PrometheusExporter::Client.default
  end

  def self.counters(*args)
    instance.counters(*args)
  end

  def self.histograms(*args)
    instance.histograms(*args)
  end

  def counters
    @counters ||= Hash.new do |hash, key|
      hash[key] = client.register(:counter, key, "count of #{key}")
    end
  end

  def histograms
    @histograms ||= Hash.new do |hash, key|
      hash[key] = client.register(:histogram, key, "histogram of #{key}")
    end
  end
end
