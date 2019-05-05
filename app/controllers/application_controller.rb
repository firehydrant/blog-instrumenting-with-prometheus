class ApplicationController < ActionController::Base
  around_action :label_metrics

  private

  def label_metrics
    Thread.current['metrics_labels'] = { controller: params[:controller], action: params[:action] }
    yield
  ensure
    Thread.current['metrics_labels'] = nil
  end
end
