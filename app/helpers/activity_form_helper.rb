module ActivityFormHelper

  def fancy_datime_select(form, field, model)
    field = field.to_s
    haml_tag :fieldset, class: field.dasherize do
      haml_tag :div, class: 'select' do
        haml_concat form.datetime_select(field.to_sym, include_blank: true)
      end
      haml_tag :input, capture_attributes(field, model, 'date')
      haml_tag :input, capture_attributes(field, model, 'time')
      if model.errors[field].any?
        haml_tag :span, model.errors[field].join(', '), class: 'validation-error-message'
      end
    end
  end

  private

    def capture_attributes(field, model, type = 'date')
      field = field.to_sym
      format = "#{type}_only".to_sym

      attributes = {
        type:        'text',
        class:       "#{type}-capture #{field.to_s.dasherize}",
        placeholder: l(current_event.send(field), format: "nice_#{type}".to_sym),
        data:        {
          update: ".#{type}-capture.#{field == :start_time ? 'end' : 'start'}-time",
          target: field,
          value: parse_date(model.send(field), format)
        }
      }

      attributes[:class] << " single-day" if current_event.single_day

      if model.errors[field].any?
        attributes[:class] << ' validation-error'
      end

      attributes
    end

    def parse_date(d, format)
      l(d, format: format) rescue nil
    end

end
