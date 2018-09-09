require "liquid/tag/parser"

class IconGridItem < Liquid::Tag
  def initialize(tag, args, tokens)
    @args = Liquid::Tag::Parser.new(args).args
    super
  end

  def render(context)
    "<div title=\"#{@args[:title]}\"><a href=\"#{@args[:url]}\"><img src=\"#{@args[:icon]}\"><div>#{@args[:name]}</div></a></div>"
  end

  Liquid::Template.register_tag "icon_grid_item", self
end
