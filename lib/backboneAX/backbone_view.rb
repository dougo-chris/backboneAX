module BackboneAX
  module BackboneView
  
    def bx_breadcrumbs(links, button = nil)
      content_tag(:ul, '', {class: 'breadcrumb'}) do
        out = []
        links.each_with_index do |value, index|         
          if index < links.length - 1
            out << content_tag(:li) do 
              safe_join [content_tag(:a, value[1], {id: value[0]}), content_tag(:span, '/', {class: 'divider'})]
            end
          else
            out << content_tag(:li, value[1])
          end
        end  
      
        unless button.nil?
          out << content_tag(:a, button[:title], button.except(:title).reverse_merge({class: ['btn', 'btn-success']}))
        end
      
        out << content_tag(:div, '', {class: 'clear'})      
      
        safe_join out
      end
    end

    #FORMS
  
    def bx_form_horontal(title = nil, form_id = nil, &block)
      capture_haml do
        haml_tag(:form, {class: 'form-horizontal', id: form_id}) do 
          haml_tag(:fieldset) do
            haml_tag(:legend, title) unless title.nil?
            yield() if block_given?          
           end
        end
      end
    end

    def bx_form_inline(title = nil, form_id = nil, &block)
      capture_haml do
        haml_tag(:form, {class: 'form-inline', id: form_id}) do 
          haml_tag(:fieldset) do
            haml_tag(:legend, title) unless title.nil?
            yield() if block_given?          
           end
        end
      end
    end

    #FIELDS
  
    def bx_field_hidden(field_id)
      capture_haml do
        haml_tag(:div, {class: 'hide'}) do
          haml_tag(:input, {type: 'hidden', id: field_id})
        end
      end
    end

    def bx_field_text(field_id, options = {})
      capture_haml do
        haml_tag(:input, options.slice(:class).merge({id: field_id}))
      end
    end

    def bx_field_textarea(field_id, options = {})
      capture_haml do
        haml_tag(:textarea, options.slice(:class, :rows).merge({id: field_id}))
      end
    end

    def bx_field_file(field_id, options = {})
      capture_haml do
        haml_tag(:input, options.slice(:class, :rows).merge({id: field_id, type: 'file'}))
      end
    end

    def bx_field_select(field_id, items ={}, options = {})
      capture_haml do
        haml_tag(:select, options.slice(:class, :multiple).merge({id: field_id})) do
          items.each do |key, value|
            haml_tag(:option, value, {value: key})
          end
        end
      end
    end

    def bx_field_password(field_id, options = {})
      capture_haml do
        haml_tag(:input, options.slice(:class, :rows).merge({id: field_id, type: 'password'}))
      end
    end

    #BUTTONS
    def bx_btn(title, field_id, options = {})
      capture_haml do
        haml_tag(:a, {class: ['btn', options[:class]], id: field_id}) do
          haml_tag(:i, '', {class: options[:icon]}) if options[:icon]
          haml_concat(title)
        end
      end
    end

    def bx_btn_primary(title, field_id, options = {})
      bx_btn(title, field_id, options.merge(class: 'btn-primary'))
    end
  
    def bx_btn_info(title, field_id, options = {})
      bx_btn(title, field_id, options.merge(class: 'btn-info'))
    end
  
    def bx_btn_success(title, field_id, options = {})
      bx_btn(title, field_id, options.merge(class: 'btn-success'))
    end
  
    def bx_btn_warning(title, field_id, options = {})
      bx_btn(title, field_id, options.merge(class: 'btn-warning'))
    end
  
    def bx_btn_danger(title, field_id, options = {})
      bx_btn(title, field_id, options.merge(class: 'btn-danger'))
    end
  
    def bx_btn_cancel(field_id = :cancel)
      bx_btn('Cancel', field_id)
    end

    def bx_btn_save(field_id = :save)
      bx_btn('Cancel', field_id, {class: 'btn-primary'})
    end

    def bx_btn_dropdown(title, options = {}, &block)
      capture_haml do
        haml_tag(:div, {class: 'btn-group'}) do
          haml_tag(:a, {class: ['btn', 'dropdown-toggle', options[:class]], 'data-toggle' => 'dropdown'}) do
            haml_tag(:i, '', {class: options[:icon]}) if options[:icon]
            haml_concat(title)
            haml_tag(:span, '', {class: :caret})
          end
          haml_tag(:ul, {class: 'dropdown-menu'}) do
            yield if block_given?
          end
        end
      end
    end

    #CONTROL_GROUP_FIELDS
    def bx_cg_text(label, field_id, options = {})
      bx_cg_group(label, field_id, options) do
        haml_tag(:input, options.slice(:class).merge({id: field_id}))
      end
    end

    def bx_cg_textarea(label, field_id, options = {})
      bx_cg_group(label, field_id, options) do
        haml_tag(:textarea, options.slice(:class, :rows).merge({id: field_id}))
      end
    end

    def bx_cg_file(label, field_id, options = {})
      bx_cg_group(label, field_id, options) do
        haml_tag(:input, options.slice(:class, :rows).merge({id: field_id, type: 'file'}))
      end
    end

    def bx_cg_select(label, field_id, items ={}, options = {})
      bx_cg_group(label, field_id, options) do
        haml_tag(:select, options.slice(:class, :multiple).merge({id: field_id})) do
          items.each do |key, value|
            haml_tag(:option, value, {value: key})
          end
        end
      end
    end

    def bx_cg_password(label, field_id, options = {})
      bx_cg_group(label, field_id, options) do
        haml_tag(:input, options.slice(:class, :rows).merge({id: field_id, type: 'password'}))
      end
    end

    protected
      def bx_cg_group(label, field_id, options = {}, &block)
        capture_haml do
          haml_tag(:div, {class: 'control-group'}) do
            haml_tag(:label, label, {class: 'control-label', for: field_id})
            haml_tag(:div, {class: 'controls'}) do
              yield() if block_given?
              haml_tag(:span, options[:help], {class: 'help-inline'}) unless options[:help].blank?
            end
          end
        end  
      end
    
  end
end