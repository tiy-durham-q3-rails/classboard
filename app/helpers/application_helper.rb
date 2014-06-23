module ApplicationHelper
  def alert_box(alert, level = "info")
    if alert
      content_tag :div, class: "row" do
        content_tag :div, :"data-alert" => "data-alert", :class => "small-12 medium-offset-1 medium-10 columns notice alert-box radius #{level}" do
          (alert + link_to("\u00D7", "#", class: "close")).html_safe
        end
      end
    end
  end

  def elapsed_time(time)
    duration = Time.zone.now - time
    output_duration(duration)
  end

  def output_duration(seconds, opts = {})
    seconds = seconds.to_i

    opts[:format] ||= :default

    days = hours = minutes = 0

    minute = 60
    hour = 60 * minute
    day = 24 * hour

    if seconds >= 60
      minutes = (seconds / 60).to_i
      seconds = seconds % 60
      if minutes >= 60
        hours = (minutes / 60).to_i
        minutes = (minutes % 60).to_i
        if hours >= 24
          days = (hours / 24).to_i
          hours = (hours % 24).to_i
        end
      end
    end

    joiner = opts.fetch(:joiner) { ' ' }

    case opts[:format]
      when :long
        dividers = { :days => ' day', :hours => ' hour', :minutes => ' minute', :seconds => ' second' }
      else
        dividers = { :days => ' day', :hours => ' hr', :minutes => ' min', :seconds => ' sec' }
    end

    units = { days: days, hours: hours, minutes: minutes, seconds: seconds }

    result = [:days, :hours, :minutes, :seconds].map do |t|
      next if t == :seconds && minutes > 0
      num = units[t]
      humanize_time_unit( num, dividers[t] )
    end.compact

    result = result.join(joiner)

    result.length == 0 ? nil : result
  end

  def humanize_time_unit(number, unit)
    return nil if number == 0
    res = "#{number}#{unit}"
    # A poor man's pluralizer
    res << 's' if !(number == 1)
    res
  end

end
