module Som
  module Liquid
    module Tags
      class ImprovedLinkTo < Locomotive::Steam::Liquid::Tags::Hybrid

        include Locomotive::Steam::Liquid::Tags::Concerns::I18nPage
        include Locomotive::Steam::Liquid::Tags::Concerns::Path

        Syntax = /(#{::Liquid::VariableSignature}+)/o

        attr_accessor :current_page

        def initialize(tag_name, markup, options)
          markup =~ Syntax
          self.set_options(markup, options)
          super
        end

        def render(context)
          self.current_page = context.registers[:page]

          render_path(context) do |page, path|
            label = label_from_page(page)

            if render_as_block?
              context.stack do
                context.scopes.last['target'] = page
                label = super.html_safe
              end
            end

            tag_attributes = build_tag_attributes(page)
            %{<a #{tag_attributes} href="#{path}">#{label}</a>}
          end
        end

        protected

        def label_from_page(page)
          if page.templatized?
            page.send(:_source).content_entry._label
          else
            page.title
          end
        end

        def page_active?(page)
          self.current_page.fullpath =~ /^#{page.fullpath}(\/.*)?$/
        end

        def build_tag_attributes(page)
          css_class = page_active?(page) ? "#{@_options[:class]} active".strip : "#{@_options[:class]}"
          tag_attributes = css_class.blank? ? "" : %{class="#{css_class}" }
          @_options.each do |key, value|
            unless (key == :class || value.blank?)
              attribute = key.to_s
              attribute = attribute.gsub('_','-') if attribute.include? "data_"
              tag_attributes << "#{attribute}=#{value} "
            end
          end
          tag_attributes.strip
        end

        def set_options(markup, options)
            @_options = {id: '', class: ''}
            markup.scan(::Liquid::TagAttributes) { |key, value| @_options[key.to_sym] = value.gsub(/"|'/, '') }
        end

      end

      ::Liquid::Template.register_tag('improved_link_to', ImprovedLinkTo)
    end
  end
end
