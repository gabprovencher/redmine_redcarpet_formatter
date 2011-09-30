module RedmineRedcarpetFormatter
  module Helper
    unloadable

    def wikitoolbar_for(field_id)
      heads_for_wiki_formatter
      url = Redmine::Utils.relative_url_root +
        Engines::RailsExtensions::AssetHelpers.plugin_asset_path('redmine_redcarpet_formatter', 'help', 'markdown_wiki_syntax.html')
      help_link = l(:setting_text_formatting) + ': ' +
        link_to(l(:label_help), url,
        :onclick => "window.open(\"#{url}\", \"\", \"resizable=yes, location=no, width=480, height=640, menubar=no, status=no, scrollbars=yes\"); return false;")
      javascript_tag(<<-EOD);
      var toolbar = new jsToolBar($('#{field_id}'));
      toolbar.setHelpLink('#{help_link}');
      toolbar.draw();
      EOD
    end


    def initial_page_content(page)
      "#{'='*page.pretty_title.length}\n#{page.pretty_title}\n#{'='*page.pretty_title.length}"
    end


    def heads_for_wiki_formatter
      unless @heads_for_wiki_formatter_included
        content_for :header_tags do
          javascript_include_tag('jstoolbar/jstoolbar') +
          javascript_include_tag('jstoolbar/redcarpet', :plugin => 'redmine_redcarpet_formatter') +
          javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
#          javascript_include_tag("lang/redcarpet-#{current_language.to_s.downcase}", :plugin => 'redmine_redcarpet_formatter') +
          stylesheet_link_tag('jstoolbar') +
          stylesheet_link_tag('html4css1', :plugin => 'redmine_redcarpet_formatter') +
          stylesheet_link_tag('redcarpet', :plugin => 'redmine_redcarpet_formatter')
        end
        @heads_for_wiki_formatter_included = true
      end
    end
  end
end
