# frozen_string_literal: true
module TermiChunk
  class Report
    X = '─'
    Y = '│'
    TL = '┌'
    BL = '└'

    attr_reader :title, :padding, :rows

    def initialize(title:, padding: nil)
      @title = title
      @padding = padding || 0
      @rows = []
      yield self if block_given?
    end

    def <<(item)
      lines = item.to_s.lines
      if item.is_a?(self.class) && padding.nonzero?
        buffer = padding.times.map { "\n" }
        lines = [*buffer, *lines, *buffer]
      end
      lines.each { |l| rows << l }
    end

    def to_s
      y = padding.times.map { Y }
      [titlebar(TL), *y, body, *y, titlebar(BL)].compact.join("\n")
    end

    private

    def body
      rows.map { |l| "#{Y} #{' ' * padding}#{l.chomp}" }.join("\n")
    end

    def titlebar(corner)
      heading = "#{corner}#{X}[ #{title} ]"
      heading += (X * (width + 2 + (padding * 2) - heading.length))
      heading
    end

    def width
      [rows.map(&:length).max + 2, title.length + 6].max
    end
  end
end
